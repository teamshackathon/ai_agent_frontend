import 'package:code/data/firebase/during_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/record/record.dart';

class FloatingRecordButton extends HookConsumerWidget {
  const FloatingRecordButton({super.key, required this.teacher});

  final String teacher;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recorder = ref.watch(streamRecorderProvider);
    final recorderNot = ref.read(streamRecorderProvider.notifier);

    void lessonStart() async {
      await recorderNot.start();
    }

    useEffect(() {
      lessonStart();
      return null;
    }, []);

    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        InkWell(
          onLongPress: () async {
            await recorderNot.stop();
            removeLessonToDuring(teacher: teacher);
          },
          child: FloatingActionButton(
            backgroundColor:
                recorder.isRecording ? Color(0xFFFF4444) : Color(0xFFEE8888),
            foregroundColor: Colors.white,
            child: recorder.isRecording ? Icon(Icons.mic) : Icon(Icons.mic_off),
            onPressed: () {
              if (recorder.isRecording) {
                recorderNot.pause();
              } else {
                recorderNot.resume();
              }
            },
          ),
        ),
      ],
    );
  }
}
