import 'package:code/widget/quiz_materials/answer_textfield.dart';
import 'package:code/widget/quiz_materials/radio_button.dart';
import 'package:flutter/material.dart';

import '../../data/quiz/quiz.dart';
import '../../data/result/result.dart';

class AnswerCheckWidget extends StatelessWidget {
  const AnswerCheckWidget({
    super.key,
    required this.index,
    required this.quiz,
    required this.result,
  });

  final int index;
  final Quiz quiz;
  final Result result;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
      Text("${index + 1}問目 : ${quiz.title}"),
      Text(quiz.question),
      if (quiz is Sentaku)
        RadioButton(
          options: (quiz as Sentaku).options,
          onChanged: (_) {},
          stateText: result.answer,
        ),
      if (quiz is Anaume || quiz is Kijutsu)
        AnswerTextboxResult(answer: result.answer),
    ];

    if (result.graded) {
      if (!result.correct) {
        widgetList.add(Text("正答 : ${result.correctAnswer}"));
      }
      widgetList.add(Text(result.description));
    } else {
      if (result.answer != quiz.correctAnswer) {
        widgetList.add(Text("模範解答 : ${quiz.correctAnswer}"));
      }
    }

    return Card(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widgetList,
          ),
          Align(
            alignment: Alignment.topRight,
            child: !result.graded
                ? Icon(Icons.hourglass_bottom)
                : result.correct
                    ? Icon(Icons.circle_outlined)
                    : Icon(Icons.close_sharp),
          ),
        ],
      ),
    );
  }
}
