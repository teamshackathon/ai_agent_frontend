import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:record/record.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AudioRecorderTest extends HookConsumerWidget {
  const AudioRecorderTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioRecorder = useMemoized(() => AudioRecorder());
    final recordingState = useState(false);
    final subscriptionRef = useRef<StreamSubscription<Uint8List>?>(null);
    final audioChunksRef = useRef(<Uint8List>[]);

    final silenceChunks = useState(0);
    final silenceThreshold = 10; // 無音と判定する閾値

    final socket =
        useMemoized(() => io.io('http://10.0.2.2:5002', <String, dynamic>{
              'transports': ['websocket'],
              'autoConnect': false,
            }));
    final messages = useState<List<String>>([]);
    final socketState = useState(false);
    final controller = useTextEditingController();

    void onPressedStop() async {
      subscriptionRef.value?.cancel();

      final recordedAudioBytes = audioChunksRef.value[0];

      print(recordedAudioBytes.length);

      for (var audio in audioChunksRef.value) {
        for (var i = 0; i < 10; i += 1) {
          final bytes = [];
          for (var j = 0; j < 10; j += 1) {
            bytes.add(
              '0x${audio[0 + i * 10 + j].toRadixString(16).padLeft(2, '0')}',
            );
          }

          print(bytes.join(' '));
        }
      }

      recordingState.value = false;
    }

    useEffect(() {
      socket.on('connect', (_) {
        Logger().i('Connected to WebSocket server');
      });

      socket.on('message', (data) {
        messages.value = [...messages.value, data];
      });

      socket.on('disconnect', (_) {
        Logger().i('Disconnected from WebSocket server');
      });

      socket.on('error', (error) {
        Logger().e('WebSocket error: $error');
      });

      return () {
        socket.dispose();
      };
    }, [socket]);

    void sendMessage() {
      if (controller.text.isNotEmpty) {
        socket.emit('message', controller.text);
        controller.clear();
      }
    }

    void sendAudio() {
      if (audioChunksRef.value.isNotEmpty) {
        socket.emit('message', audioChunksRef.value.join());
        // audioChunksRefを空にする
        audioChunksRef.value = [];
      }
    }

    void onAudioDataAvailable(Uint8List audioChunk) {
      // 音の取り始めを理解させる
      // デシベル検知がいるのでは
      audioChunksRef.value = [...audioChunksRef.value, audioChunk];
      final sum = audioChunk.reduce((a, b) => a + b);

      if (sum < silenceThreshold) {
        silenceChunks.value++;
      } else {
        silenceChunks.value = 0;
      }

      if (silenceChunks.value > 20) {
        silenceChunks.value = 0;
        if (recordingState.value) {
          Logger().i('Silence detected. Save recording...');
          sendAudio();
        }
      }
    }

    void onPressStart() async {
      if (await audioRecorder.hasPermission()) {
        audioChunksRef.value = [];
        final stream = await audioRecorder
            .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
        subscriptionRef.value = stream.listen(onAudioDataAvailable);
        recordingState.value = true;
      }
    }

    return Placeholder();
  }
}
