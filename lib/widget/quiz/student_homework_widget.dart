import 'package:code/data/quiz/quiz.dart';
import 'package:code/widget/quiz/quiz_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentHomeworkWidget extends ConsumerWidget {
  const StudentHomeworkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizList = ref.read(quizNotifierProvider);
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => QuizEditWidget(
          editable: true, quiz: quizList[index], onChanged: onChanged),
      itemCount: quizList.length,
    ));
  }
}
