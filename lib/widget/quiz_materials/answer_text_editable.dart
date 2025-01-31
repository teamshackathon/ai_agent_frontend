import 'package:flutter/material.dart';

class AnswerTextEditable extends StatelessWidget {
  const AnswerTextEditable({
    super.key,
    required this.correctAnswer,
    required this.onChanged,
    required this.editable,
  });
  final String correctAnswer;
  final bool editable;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        initialValue: correctAnswer,
        onChanged: onChanged,
        enabled: editable,
      ),
    );
  }
}
