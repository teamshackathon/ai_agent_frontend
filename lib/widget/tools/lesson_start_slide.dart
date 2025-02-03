import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/sakura_progress_indicator.dart';

class LessonStartSlide extends ConsumerWidget {
  const LessonStartSlide({
    super.key,
    this.width = 400,
    this.height = 80,
  });

  final double width, height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final during = ref.watch(duringStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);
    final currentLessonStream = ref.watch(currentLessonStreamProvider);

    return during.when(
      data: (snapshot) {
        switch (duringLesson(
          snapshotData: snapshot.docs,
          roomNumber: currentRoom.roomNumber,
          subject: currentRoom.subject,
          count: currentLessonStream!.data().count,
        )) {
          case true:
            return Text("授業中です");
          case false:
            return Text("他のコマで授業中です");
          default:
            return SwipeButton.expand(
              width: width,
              height: height,
              child: Text("授業開始"),
              onSwipeEnd: () async {
                await addLessonToDuring(
                  roomNumber: currentRoom.roomNumber,
                  subject: currentRoom.subject,
                  count: currentLessonStream.data().count,
                  teacher: currentRoom.teacher,
                );
              },
            );
        }
      },
      // エラー時の表示
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
