import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:convert';

import 'package:code/data/firebase/lesson_stream.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../toast.dart';
import '../firebase/during_stream.dart';
import '../person/person.dart';

part 'record.freezed.dart';

part 'record.g.dart';

@freezed
class StreamRecord with _$StreamRecord {
  const factory StreamRecord({
    required AudioRecorder recorder,
    required Socket socket,
    @Default(false) bool isRecording,
    @Default(0.0) double dB, // 外から見る用
  }) = _StreamRecord;
}

@Riverpod(keepAlive: true)
class StreamRecorder extends _$StreamRecorder {
  final List<String> messages = [];
  StreamSubscription<Uint8List>? subscription;
  final List<int> audioChunks = [];
  var silenceChunks = 0;
  var breakSilence = false;

  // 教室の通常のdBは45ぐらいで想定、要調整
  // 設定欄から感度調整バーがあってもいいかも
  // SharedPreferenceで端末側に情報を残して
  final dBThreshold = 45.0;

  // 下のページを見る限り、1chunk0.1secっぽい
  // https://zenn.dev/tatsuyasusukida/scraps/c9503b9fec2e51
  // とりあえず規定時間を二秒にしておく
  final silenceDuring = 20;

  @override
  StreamRecord build() {
    final recorder = AudioRecorder();
    final socket = io(
      'http://10.0.2.2:5002',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    socket.onConnect((_) => infoToast(log: "WebSocket Connected"));
    socket.on("message", (data) => messages.add(data));
    socket.onDisconnect((_) {
      infoToast(log: messages);
      infoToast(log: "WebSocket Disconnected");
    });
    socket.on('error', (error) => infoToast(log: "WebSocket Error : $error"));
    return StreamRecord(recorder: recorder, socket: socket);
  }

  // utf8 base64に変換する必要ある
  void _sendAudio() {
    if (audioChunks.isNotEmpty) {
      // 送信データをどうすればいいか確認
      state.socket.emit("message", base64Encode(audioChunks));
      audioChunks.clear();
      silenceChunks = 0;
    }
  }

  double _calcRMS(Int16List data) {
    double squareSum =
        data.map((d) => (d * d).toDouble()).reduce((a, b) => a + b);
    return math.sqrt(squareSum / data.length);
  }

  void _onAudioDataAvailable(Uint8List audioChunk) {
    // 音声データの実効値を計算して、dBに変換(AI三人に聞きました)
    var pcmData = Int16List.view(audioChunk.buffer);
    var rms = _calcRMS(pcmData);
    var currentDB = 20 *
        math.log(math.max(rms / 32767, 0.000000000001)) / // 0来てバグらないように
        math.ln10;

    state = state.copyWith(dB: currentDB);

    // しきい値を下回ってるか
    if (currentDB < dBThreshold) {
      // ずっと沈黙が続いていなければ
      if (breakSilence) {
        silenceChunks++;
        // 沈黙し始めても少しの間はデータ格納
        if (silenceChunks <= silenceDuring / 2) {
          audioChunk.map((data) => audioChunks.add(data));
        }
      }
    } else {
      audioChunk.map((data) => audioChunks.add(data));
      breakSilence = true;
      silenceChunks = 0;
    }

    if (silenceChunks > silenceDuring) {
      infoToast(log: 'Silence detected. Save recording...');
      _sendAudio();
      // ここで長い沈黙とみなす
      breakSilence = false;
    }
  }

  Future<bool> _permission() async {
    if (await state.recorder.hasPermission()) return true;
    final user = await ref.watch(personStatusProvider.future);
    final current = ref.watch(currentLessonStreamProvider);
    cancelLessonToDuring(teacher: user.name, currentLesson: current!.data());
    return false;
  }

  Future<void> _startRecorder() async {
    audioChunks.clear();
    final stream = await state.recorder
        .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    subscription = stream.listen(_onAudioDataAvailable);
    state = state.copyWith(isRecording: true);
  }

  Future<void> start() async {
    if (await _permission()) {
      state.socket.connect();
      await _startRecorder();
    }
  }

  Future<void> pause() async {
    await state.recorder.pause();
    _sendAudio();
    state = state.copyWith(isRecording: false);
  }

  Future<void> resume() async {
    if (await _permission()) {
      await state.recorder.resume();
      state = state.copyWith(isRecording: true);
    }
  }

  Future<void> stop() async {
    subscription!.cancel();
    state.recorder.stop();
    state.socket.disconnect();
    state = state.copyWith(isRecording: false);
  }
}
