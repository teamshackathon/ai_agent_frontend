import 'package:flutter/material.dart';

class QuizText extends StatelessWidget{
  const QuizText({
    super.key,
    required this.quizText,
  });
  final String quizText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 150,
      child: Text(quizText),
    );
  }
}