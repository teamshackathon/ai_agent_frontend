import 'package:flutter/material.dart';

class AnswerTextbox extends StatelessWidget {
  const AnswerTextbox({
    super.key,
    required this.answer,
    required this.onChanged,
  });
  final String answer;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        initialValue: answer,
        onChanged: onChanged,
      ),
    );
  }
}

class AnswerTextboxResult extends StatelessWidget {
  const AnswerTextboxResult({
    super.key,
    required this.answer,
  });
  final String answer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Text(
        answer,
      ),
    );
  }
}
