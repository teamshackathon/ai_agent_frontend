import 'dart:math' as math;

import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
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
    final dB = recorder.dB;
    final double elevation = math.min(math.max((dB + 60) / 10, 1.5), 20.0);
    final lesson = ref.watch(currentLessonStreamProvider);

    void lessonStart() async {
      await recorderNot.start();
    }

    void lessonEnd() async{
      if(await recorder.recorder.isRecording()){
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
    return InkWell(
      onLongPress: () async {
        await recorderNot.stop();
        breakLessonToDuring(teacher: teacher, currentLesson: lesson!.data());
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        decoration: BoxDecoration(
          shape: BoxShape.circle, // 🔥 これで影を含めて円形にする
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: elevation, // 影の大きさをアニメーション
              spreadRadius: elevation / 2,
            ),
          ],
        ),
        child: Material(
          // 🔥 Web で確実に丸くするために Material をラップ
          shape: CircleBorder(),
          color: Colors.transparent,
          elevation: 0, // 影は `AnimatedContainer` に任せる
          child: FloatingActionButton(
            shape: CircleBorder(),
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
      ),
    );
  }
}
