import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentHomeworkWidget extends ConsumerWidget {
  const StudentHomeworkWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      // child: ListView.builder(
      //   itemBuilder: (context, index) => QuizEditWidget(
      //       editable: true, quiz: quizList[index], onChanged: onChanged),
      //   itemCount: quizList.length,
      // ),
      child: Text("hoge"),
    );
  }
}
