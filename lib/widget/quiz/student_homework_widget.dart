import 'package:code/data/quiz/quiz.dart';
import 'package:code/widget/quiz/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudentHomeworkWidget extends ConsumerWidget {
  const StudentHomeworkWidget({
    super.key,
    required this.quizList,
    required this.onChanged,
    required this.count,
  });
  final List<Quiz> quizList;
  final int count;
  final ValueChanged<Quiz> onChanged;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => AnswerWidget(
          quiz: quizList[index],
          onChanged: (quiz) => onChanged,
          count: count,
        ),
        itemCount: quizList.length,
      ),
    );
  }
}

class StudentHomeworkResultWidget extends ConsumerWidget {
  const StudentHomeworkResultWidget({
    super.key,
    required this.quizList,
    required this.count,
  });
  final List<Quiz> quizList;
  final int count;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => AnswerResultWidget(
          quiz: quizList[index],
          count: count,
        ),
        itemCount: quizList.length,
      ),
    );
  }
}
