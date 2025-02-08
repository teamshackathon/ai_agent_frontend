import 'package:code/data/firebase/submission_stream.dart';
import 'package:code/data/quiz/quiz.dart';
import 'package:code/data/submission/submission.dart';
import 'package:code/toast.dart';
import 'package:code/widget/quiz/student_homework_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';

class StudentHomework extends ConsumerWidget {
  const StudentHomework({super.key, required this.lesson});
  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submitStream = ref.watch(submissionStreamProvider);
    return submitStream.when(
        data: (snap) {
          if (snap.docs.isEmpty ||
              snap.docs[0].toString() == "null" ||
              snap.docs[0].data().homeworks.isEmpty) {
            return anasked();
          } else {
            infoToast(log: "useLog: ${snap.docs[0]} size: ${snap.size} ");
            return StudentHomeworkMain(
              submit: snap.docs[0].data(),
              count: lesson.count,
            );
          }
        },
        error: (error, stactrace) => errorDisplay(),
        loading: loading);
  }

  Widget errorDisplay() {
    return Center(child: Text("読み込みに失敗しました。"));
  }

  Widget loading() {
    return Icon(Icons.self_improvement);
  }

  Widget anasked() {
    return Center(child: Text("宿題はまだありません。"));
  }
}

class StudentHomeworkMain extends ConsumerWidget {
  const StudentHomeworkMain(
      {super.key, required this.submit, required this.count});
  final Submission submit;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizList = useState<List<Quiz>>(submit.homeworks);

    if (submit.homeworkResults.isEmpty) {
      return StudentHomeworkWidget(
        count: count,
        quizList: quizList.value,
        onChanged: (value) =>
            quizList.value = QuizList(quizList.value).replaceQuiz(value),
      );
    } else {
      quizList.value =
          QuizList(quizList.value).readResult(submit.homeworkResults);
      return StudentHomeworkResultWidget(
        quizList: quizList.value,
        count: count,
      );
    }
  }
}
