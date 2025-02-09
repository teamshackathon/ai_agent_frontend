import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../api/api.dart';
import '../../../../data/firebase/submission_stream.dart';
import '../../../../data/person/person.dart';
import '../../../../data/quiz/quiz.dart';
import '../../../../data/result/result.dart';
import '../../../../data/submission/submission.dart';
import '../../../../widget/answer_check/answer_check.dart';
import '../../../../widget/quiz/answer_widget.dart';
import '../../../../widget/utils/loading_button.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

final homeworkDraggableProvider = StateProvider<bool>((ref) => false);

class StudentHomework extends ConsumerWidget {
  const StudentHomework({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homework = ref.watch(submissionStreamProvider);

    return Center(
      child: homework.when(
          data: (snap) {
            if (snap.docs.isEmpty || snap.docs[0].data().homeworks.isEmpty) {
              return const Text("宿題はまだありません。");
            } else {
              if (snap.docs[0].data().homeworkResults.isEmpty) {
                return StudentHomeworkWidget(submission: snap.docs[0].data());
              } else {
                return StudentHomeworkCheck(submission: snap.docs[0].data());
              }
            }
          },
          error: (_, __) => const Text("読み込みに失敗しました。"),
          loading: () => const SakuraProgressIndicator()),
    );
  }
}

class StudentHomeworkWidget extends ConsumerWidget {
  const StudentHomeworkWidget({super.key, required this.submission});

  final Submission submission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draggable = ref.watch(homeworkDraggableProvider);
    final reference = submission.reference;

    return ScrollConfiguration(
      // chrome上でスワイプを検知するために必要、実機ではいらない
      behavior: _MouseDraggableScrollBehavior(),
      child: PageView(
        physics: draggable ? null : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          StudentHomeworkDisplay(submission: submission),
          SizedBox(),
        ],
        onPageChanged: (page) async {
          final student = await ref.watch(personStatusProvider.future);
          final list = [
            for (final quiz in submission.homeworks) quiz.answerToMap()
          ];
          await reference
              .update({"homeworks_answer": list, "name": student.name});
          await submitHomework(reference.path, []);
        },
      ),
    );
  }
}

class _MouseDraggableScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class StudentHomeworkDisplay extends HookConsumerWidget {
  const StudentHomeworkDisplay({super.key, required this.submission});

  final Submission submission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = submission.reference;
    final quizzes = useState<List<Quiz>>(submission.homeworks);
    final draggable = ref.watch(homeworkDraggableProvider);
    final draggableNot = ref.watch(homeworkDraggableProvider.notifier);
    final loading = useState<bool>(false);

    return Column(
      children: [
        SizedBox(height: 10),
        Flexible(
          child: ListView.separated(
            itemCount: quizzes.value.length,
            itemBuilder: (context, index) => AnswerWidget(
              count: index + 1,
              quiz: quizzes.value[index],
              onChanged: (str) {
                quizzes.value = [
                  for (final quiz in quizzes.value)
                    quizzes.value[index].title == quiz.title
                        ? quiz.copyWith(answer: str)
                        : quiz
                ];
                draggableNot.state = false;
              },
            ),
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
          ),
        ),
        SizedBox(height: 20),
        Visibility(
          visible: !draggable,
          child: LoadingButton(
            width: 100,
            onPressed: () async {
              loading.value = true;
              final student = await ref.watch(personStatusProvider.future);
              final list = [for (final quiz in quizzes.value) quiz.toMap()];
              await reference.update({"homeworks": list, "name": student.name});
              draggableNot.state = true;
              loading.value = false;
            },
            isLoading: loading.value,
            text: "保存",
          ),
        ),
        Visibility(
          visible: draggable,
          child: Text(
            "上にスワイプしてテスト開始",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class StudentHomeworkCheck extends HookConsumerWidget {
  const StudentHomeworkCheck({super.key, required this.submission});

  final Submission submission;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = submission.homeworks;
    final results = sortWithQuizzes(submission.homeworkResults, quizzes);
    var score = 0;
    var total = 0;

    for (var i = 0; i < quizzes.length; i++) {
      var q = quizzes[i];
      var r = results[i];
      total = total + q.score;
      if (r.graded ? r.correct : r.answer == q.correctAnswer) {
        score = score + q.score;
      }
    }

    return ListView.builder(
      itemCount: quizzes.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Center(
            child: Text(
              "点数　：　$score / $total",
              style: TextStyle(fontSize: 20),
            ),
          );
        }
        if (index == quizzes.length + 1) {
          return SizedBox(height: 25);
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
