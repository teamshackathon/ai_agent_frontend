import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/submission_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../data/result/result.dart';
import '../../../../data/submission/submission.dart';
import '../../../../widget/answer_check/answer_check.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class StudentAnswerCheck extends ConsumerWidget {
  const StudentAnswerCheck({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submissions = ref.watch(submissionStreamProvider);
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: submissions.when(
          data: (snapshot) => StudentAnswerCheckDisplay(
            lesson: lesson,
            submission: snapshot.size > 0 ? snapshot.docs[0].data() : null,
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
          // エラー時の表示
          error: (_, __) => const Center(child: Text("読み込み失敗")),
          // 読込中の表示
          loading: () => const Center(child: SakuraProgressIndicator()),
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
  final Submission? submission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (submission == null || submission!.testResults.isEmpty) {
      return const Center(child: Text("テストを受けていません"));
    }
    final quizzes = lesson.questionsPublish;
    final results = sortWithQuizzes(submission!.testResults, quizzes);

    return ListView.builder(
      itemCount: quizzes.length,
      itemBuilder: (context, index) => AnswerCheckWidget(
        index: index,
        quiz: quizzes[index],
        result: results[index],
      ),
    );
  }
}
