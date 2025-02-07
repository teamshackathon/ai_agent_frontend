import 'package:flutter/material.dart';

class QuizText extends StatelessWidget {
  const QuizText({
    super.key,
    required this.quizText,
  });
  final String quizText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(quizText),
    );
  }
}

class QuizTextEditable extends StatelessWidget {
  const QuizTextEditable({
    super.key,
    required this.editable,
    required this.onChanged,
    required this.quizText,
  });
  final String quizText;
  final bool editable;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        maxLines: null,
        initialValue: quizText,
        onChanged: onChanged,
        enabled: editable,
      ),
    );
  }
}
