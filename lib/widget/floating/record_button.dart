import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/record/record.dart';

class RecordButton extends HookConsumerWidget {
  const RecordButton({super.key, required this.teacher, required this.reference});

  final String teacher;

  final DocumentReference reference;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recorder = ref.watch(streamRecorderProvider);
    final recorderNot = ref.read(streamRecorderProvider.notifier);

    void lessonStart() async {
      await recorderNot.start(reference);
    }

    void lessonEnd() async {
      if (await recorder.recorder.isRecording()) {
        await recorderNot.stop();
      }
    }

    useEffect(() {
      lessonStart();
      return lessonEnd;
    }, []);

    // ここまで大げさにしないとchromeだとボタンが四角くなる仕様
    // androidだったらここまでやらなくても大丈夫なはず
    // chatGPTなきゃ辿り着けんてそれは
    return IconButton(
      icon: recorder.isRecording ? Icon(Icons.mic) : Icon(Icons.mic_off),
      onPressed: () {
        if(!recorderNot.busy){
          if (recorder.isRecording) {
            recorderNot.pause();
          } else {
            recorderNot.resume();
          }
        }
      },
    );
  }
}
