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
    return TextFormField(
      maxLines: null,
      initialValue: quizText,
      onChanged: onChanged,
      enabled: editable,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
