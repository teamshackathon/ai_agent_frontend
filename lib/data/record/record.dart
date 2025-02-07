import 'dart:async';
import 'dart:typed_data';
import 'dart:math' as math;
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../toast.dart';
import '../firebase/during_stream.dart';
import '../firebase/tools_stream.dart';
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
  final List<Uint8List> audioChunks = [];
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

  WebSocketChannel? _channel;

  @override
  StreamRecord build() {
    final recorder = AudioRecorder();
    final socket = io(
        'http://localhost:3002',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.onConnect((_) {
      infoToast(log: "WebSocket Connect");
    });
    socket.onDisconnect((_) {
      infoToast(log: messages);
      infoToast(log: "WebSocket Disconnected");
    });
    socket.on('message', (_) => infoToast(log: _));
    socket.onError((error) => infoToast(log: "WebSocket Error : $error"));

    socket.onConnectError(
        (error) => infoToast(log: "WebSocket Connect Error : $error"));

    return StreamRecord(recorder: recorder, socket: socket);
  }

  // utf8 base64に変換する必要ある
  void _sendAudio() {
    if (audioChunks.isNotEmpty) {
      // 送信データをどうすればいいか確認

      final audioData =
          Uint8List.fromList(audioChunks.expand((x) => x).toList());

      //state.socket.emit('audio_data', Uint8List.fromList(audioData));
      _channel!.sink.add(Uint8List.fromList(audioData));
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
            math.ln10 +
        85; // 基準を調整

    state = state.copyWith(dB: currentDB);

    //infoToast(log: 'AudioData Loading. $currentDB | $dBThreshold');
    // しきい値を下回ってるか
    if (currentDB < dBThreshold) {
      // ずっと沈黙が続いていなければ
      if (breakSilence) {
        silenceChunks++;
        // 沈黙し始めても少しの間はデータ格納
        if (silenceChunks <= silenceDuring / 2) {
          audioChunks.add(audioChunk);
        }
      }
    } else {
      audioChunks.add(audioChunk);
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
    final current = ref.watch(currentLessonProvider);
    cancelLessonToDuring(teacher: user.name, currentLesson: current);
    return false;
  }

  Future<void> _startRecorder() async {
    audioChunks.clear();
    final stream = await state.recorder
        .startStream(const RecordConfig(encoder: AudioEncoder.wav));
    subscription = stream.listen(_onAudioDataAvailable);
    state = state.copyWith(isRecording: true);
  }

  Future<void> start() async {
    if (await _permission()) {
      //state.socket.connect();
      _channel = WebSocketChannel.connect(Uri.parse('ws://localhost:3002'));
      // サーバーからメッセージを受け取るためのリスナーを追加
      _channel?.stream.listen((message) {
        try {
          infoToast(log: message);
          if (message == 'quit') {
            // 授業終了
            stop();
          }
        } catch (e) {
          infoToast(log: 'Failed Message: $e');
        }
      });
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
    _sendAudio();
    state.recorder.stop();
    //state.socket.dispose();
    _channel?.sink.close();
    state = state.copyWith(isRecording: false);
  }
}
