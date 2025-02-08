import 'package:code/data/firebase/submission_stream.dart';
import 'package:code/data/quiz/quiz.dart';
import 'package:code/data/result/result.dart';
import 'package:code/widget/quiz/student_homework_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';

class StudentHomework extends ConsumerWidget {
  const StudentHomework({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homework = ref.watch(submissionStreamProvider);
    final homeworkNot = QuizNotifier();
    return homework.when(
        data: (snap) {
          if (snap.docs.isEmpty || snap.docs[0].data().homeworks.isEmpty) {
            return anasked();
          } else {
            homeworkNot.init(snap.docs[0].data().homeworks);
            if (snap.docs[0].data().homeworkResults.isEmpty) {
              return StudentHomeworkWidget();
            } else {
              homeworkNot.readResult(snap.docs[0].data().homeworkResults);
              return StudentHomeworkWidget();
            }
          }
        },
        error: (error, stactrace) => errorDisplay(),
        loading: loading);
  }

  Widget anasked() {
    return Center(child: Text("宿題はまだありません。"));
  }

  Widget errorDisplay() {
    return Center(child: Text("読み込みに失敗しました。"));
  }

  Widget loading() {
    return Icon(Icons.self_improvement);
  }
}
