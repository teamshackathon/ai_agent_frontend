import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firebase/tools_stream.dart';
import '../../data/lesson/lesson.dart';
import '../../pages/student/main/tools/student_answer_check.dart';
import '../utils/sakura_progress_indicator.dart';

class StudentQuizTabBarView extends HookConsumerWidget {
  const StudentQuizTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(toolsStreamProvider);
    return lessonStream.when(
      data: (snapshot) =>
          StudentAnswerCheck(lesson: snapshot.data() ?? Lesson.isBlank()),
      // エラー時の表示
      error: (_, __) => const Center(child: Text("読み込み失敗")),
      // 読込中の表示
      loading: () => const Center(child: SakuraProgressIndicator()),
    );
  }
}