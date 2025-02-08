import 'package:flutter/material.dart';

import '../../data/quiz/quiz.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.options,
    required this.onChanged,
    required this.stateText,
  });

  final List<Option> options;
  final String stateText;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RadioListTile(
              title: Text(options[index].word),
              value: options[index].word,
              groupValue: stateText,
              onChanged: onChanged,
            ));
      },
    );
  }
}

class AnswerRadioButton extends StatelessWidget {
  const AnswerRadioButton({
    super.key,
    required this.options,
    required this.stateText,
    required this.correctAnswer,
  });

  final List<Option> options;
  final String stateText, correctAnswer;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        final List<Widget> title = [
          Text(
            "${options[index].word}  ",
            style: TextStyle(fontSize: 16, height: 0),
          )
        ];

        if (options[index].word == stateText) {
          if (stateText == correctAnswer) {
            title.add(SizedBox(
              width: 20,
              height: 25,
              child: Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child:
                      Icon(Icons.circle_outlined, color: Colors.red, size: 18)),
            ));
          } else {
            title.add(SizedBox(
              width: 20,
              height: 25,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Icon(Icons.close_sharp, color: Colors.blue, size: 23),
              ),
            ));
          }
        } else if (options[index].word == correctAnswer) {
          title.add(SizedBox(
            width: 20,
            height: 20,
            child: Padding(
                padding: const EdgeInsets.only(left: 3),
                child:
                    Icon(Icons.circle_outlined, color: Colors.red, size: 18)),
          ));
        }

        return RadioListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: title,
          ),
          value: options[index].word,
          groupValue: stateText,
          onChanged: options[index].word == stateText ||
                  options[index].word == correctAnswer
              ? (_) {}
              : null,
        );
      },
    );
  }
}
