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
      height: 60,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        maxLines: null,
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
    this.correct,
  });

  final String answer;
  final bool? correct;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "$answer  ",
          style: TextStyle(fontSize: 16, height: 0),
          maxLines: null,
        ),
        if (correct != null)
          correct!
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.circle_outlined,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                )
              : SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(
                    Icons.close_sharp,
                    color: Colors.blue,
                    size: 23,
                  ),
                ),
      ],
    );
  }
}
