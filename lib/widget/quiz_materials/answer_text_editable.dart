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
    return TextFormField(
      maxLines: null,
      initialValue: correctAnswer,
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
