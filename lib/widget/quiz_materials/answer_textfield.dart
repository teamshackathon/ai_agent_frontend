import 'package:flutter/material.dart';

class AnswerTextbox extends StatelessWidget{
  const AnswerTextbox({
    super.key,
    required this.answer,
    required this.onchange,
  });
    final String answer;
    final ValueChanged<String> onchange;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width *0.8,
      child: TextField(
        
        onChanged: onchange,
      )
    );
  }
}