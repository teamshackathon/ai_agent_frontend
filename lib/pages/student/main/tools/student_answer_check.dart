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
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: submissions.when(
          data: (snapshot) {
            return StudentAnswerCheckDisplay(
              lesson: lesson,
              submission: snapshot.size > 0 ? snapshot.docs[0].data() : null,
            );
          },
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
    required this.lesson,
    required this.submission,
  });

  final Lesson lesson;
  final Submission? submission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (submission == null || submission!.testResults.isEmpty) {
      return const Center(child: Text("テストを受けていません"));
    }
    final quizzes = lesson.questionsPublish;
    final results = sortWithQuizzes(submission!.testResults, quizzes);
    var score = 0;
    var total = 0;

    for (var i = 0; i < quizzes.length; i++) {
      var q = quizzes[i];
      var r = results[i];
      total = total + q.score;
      if (r.graded ? r.correct : q.answer == q.correctAnswer) {
        score = score + q.score;
      }
    }

    return ListView.builder(
      itemCount: quizzes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Center(child: Text("点数　：　$score / $total"));
        }
        return AnswerCheckWidget(
          index: index - 1,
          quiz: quizzes[index - 1],
          result: results[index - 1],
        );
      },
    );
  }
}
