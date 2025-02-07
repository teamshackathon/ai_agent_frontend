import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firebase/during_stream.dart';
import '../../data/firebase/lesson_stream.dart';
import '../../data/lesson/lesson.dart';
import '../../data/record/record.dart';
import '../utils/sakura_progress_indicator.dart';

class LessonSlide extends ConsumerWidget {
  const LessonSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final during = ref.watch(duringStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);

    if (lesson.state == "" || lesson.state == "after") {
      return Text("授業完了");
    }

    return during.when(
      data: (snap) {
        switch (duringLesson(
          snapshotData: snap.docs,
          roomNumber: currentRoom.roomNumber,
          subject: currentRoom.subject,
          count: lesson.count,
        )) {
          case false:
            return Text("他のコマで授業中です");

          case true:
            return LessonCancelSlide();

          default:
            return LessonStartSlide();
        }
      }, // エラー時の表示
      error: (_, __) => const Center(
        child: Text("読み込み失敗"),
      ),
      // 読込中の表示
      loading: () => const Center(
        child: SakuraProgressIndicator(),
      ),
    );
  }
}

class LessonStartSlide extends ConsumerWidget {
  const LessonStartSlide({
    super.key,
    this.width = 400,
    this.height = 60,
  });

  final double width, height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final currentRoom = ref.watch(currentRoomProvider);

    return SwipeButton.expand(
      width: width,
      height: height,
      child: Text("授業開始"),
      onSwipeEnd: () async {
        await addLessonToDuring(
          roomNumber: currentRoom.roomNumber,
          subject: currentRoom.subject,
          count: lesson.count,
          teacher: currentRoom.teacher,
          currentLesson: lesson,
        );
      },
    );
  }
}

class LessonCancelSlide extends ConsumerWidget {
  const LessonCancelSlide({
    super.key,
    this.width = 400,
    this.height = 60,
  });

  final double width, height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final currentRoom = ref.watch(currentRoomProvider);
    final recorder = ref.watch(streamRecorderProvider);
    final recorderNot = ref.read(streamRecorderProvider.notifier);

    return SwipeButton.expand(
      width: width,
      height: height,
      child: Text("授業終了"),
      onSwipeEnd: () async {
        if (lesson.state != "break") {
          await cancelLessonToDuring(
            teacher: currentRoom.teacher,
            currentLesson: lesson,
          );
        } else {
          await finishLessonToDuring(
            teacher: currentRoom.teacher,
            currentLesson: lesson,
          );
        }
        if (recorder.isRecording) {
          await recorderNot.stop();
        }
      },
    );
  }
}
