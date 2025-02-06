import 'package:code/data/result/result.dart';
import 'package:code/widget/answer_check/answer_check.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/lesson_stream.dart';
import '../../../../data/firebase/submission_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../data/submission/submission.dart';
import '../../../../widget/base_page/base_page.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class StudentAnswerCheck extends ConsumerWidget {
  const StudentAnswerCheck({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final results = ref.watch(submissionStreamProvider);
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "小テスト確認",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: results.when(
            data: (snapshot) => StudentAnswerCheckDisplay(
              lesson: lesson,
              submission: snapshot.docs[0].data(),
              displayWidth: size.width * widthFactor,
              displayHeight: size.height * widthFactor,
            ),
            // エラー時の表示
            error: (_, __) => const Center(child: Text("読み込み失敗")),
            // 読込中の表示
            loading: () => const Center(child: SakuraProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class StudentAnswerCheckDisplay extends HookConsumerWidget {
  const StudentAnswerCheckDisplay({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
    required this.lesson,
    required this.submission,
  });

  final double displayWidth, displayHeight;
  final Lesson lesson;
  final Submission submission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = lesson.questionsPublish;
    final results = sortWithQuizzes(submission.testResults, quizzes);

    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: quizzes.length,
            itemBuilder: (context, index) => AnswerCheckWidget(
              index: index,
              quiz: quizzes[index],
              result: results[index],
            ),
          ),
        ),
      ],
    );
  }
}
