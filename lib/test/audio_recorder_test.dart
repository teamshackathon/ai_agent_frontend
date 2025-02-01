import 'dart:async';
import 'dart:typed_data';

import 'package:code/dummy/widget/dummy_base_page.dart';
import 'package:code/toast.dart';
import 'package:code/widget/base_page/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';

class AudioRecorderTest extends HookConsumerWidget {
  const AudioRecorderTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioRecorder = useMemoized(() => AudioRecorder());
    final recordingState = useState(false);
    final subscriptionRef = useRef<StreamSubscription<Uint8List>?>(null);
    final audioChunksRef = useRef(<Uint8List>[]);
    final chunkString = useState<String>("");

    void onAudioDataAvailable(Uint8List audioChunk) {
      audioChunksRef.value = [...audioChunksRef.value, audioChunk];
      chunkString.value = audioChunk.toString();
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

    return DummyBasePage(
      pageTitle: "録音テスト",
      floatingActionButton: FloatingActionButton(
        backgroundColor: recordingState.value ? Colors.red : Colors.blue,
        onPressed: () async {
          if (recordingState.value) {
            onPressedStop();
          } else {
            onPressStart();
          }
        },
      ),
      body: Text(
        chunkString.value,
        maxLines: null,
        style: TextStyle(fontSize: 5),
      ),
    );
  }
}
