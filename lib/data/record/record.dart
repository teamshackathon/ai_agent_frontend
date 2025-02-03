import 'dart:async';
import 'dart:typed_data';

import 'package:code/toast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'record.freezed.dart';

part 'record.g.dart';

@freezed
class StreamRecord with _$StreamRecord {
  const factory StreamRecord({
    required AudioRecorder recorder,
    required Socket socket,
    @Default(false) bool isRecording,
  }) = _StreamRecord;
}

@Riverpod(keepAlive: true)
class StreamRecorder extends _$StreamRecorder {
  final List<String> messages = [];
  StreamSubscription<Uint8List>? subscription;
  final List<Uint8List> audioChunks = [];

  // 外からこれを参照すれば、声に反応して光らせたりできるかも
  Uint8List currentChunk = Uint8List(0);
  var silenceChunks = 0;
  final silenceThreshold = 10;
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

  void _sendAudio() {
    if (audioChunks.isNotEmpty) {
      state.socket.emit("message", audioChunks.join());
      audioChunks.clear();
      silenceChunks = 0;
    }
  }

  void _onAudioDataAvailable(Uint8List audioChunk) {
    // 音の取り始めを理解させる
    // デシベル検知がいるのでは
    audioChunks.add(audioChunk);
    final sum = audioChunk.reduce((a, b) => a + b);

    if (sum < silenceThreshold) {
      silenceChunks++;
    } else {
      silenceChunks = 0;
    }

    if (silenceChunks > silenceDuring) {
      if (state.isRecording) {
        infoToast(log: 'Silence detected. Save recording...');
        _sendAudio();
      }
    }
  }

  Future<void> _startRecorder() async {
    audioChunks.clear();
    final stream = await state.recorder
        .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    subscription = stream.listen(_onAudioDataAvailable);
    state = state.copyWith(isRecording: true);
  }

  Future<void> start() async {
    if (await state.recorder.hasPermission()) {
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
    await state.recorder.resume();
    state = state.copyWith(isRecording: true);
  }

  Future<void> stop() async {
    subscription!.cancel();
    state.recorder.stop();
    state.socket.disconnect();
    state = state.copyWith(isRecording: false);
  }
}
