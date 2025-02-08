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
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "${index + 1}問目 : ${quiz.title}",
          style: TextStyle(fontSize: 18),
        ),
      ),
      SizedBox(height: 10),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          "　${quiz.question}",
          style: TextStyle(fontSize: 15),
        ),
      ),
      SizedBox(height: 5),
    ];

    if (quiz is Sentaku) {
      widgetList.add(AnswerRadioButton(
        options: (quiz as Sentaku).options,
        stateText: result.answer,
        correctAnswer:
            result.graded ? result.correctAnswer : quiz.correctAnswer,
      ));
    }

    if (quiz is Anaume || quiz is Kijutsu) {
      widgetList.add(Align(
        alignment: Alignment.bottomRight,
        child: AnswerTextboxResult(
          answer: "回答 ：　${result.answer}",
          correct: result.correct || result.answer == quiz.correctAnswer,
        ),
      ));
      if (!result.correct && result.answer != quiz.correctAnswer) {
        widgetList.add(SizedBox(height: 5));
        widgetList.add(Align(
          alignment: Alignment.bottomRight,
          child: AnswerTextboxResult(
            answer: result.graded ? result.correctAnswer : quiz.correctAnswer,
            correct: true,
          ),
        ));
      }
    }

    if (result.graded) {
      widgetList.add(SizedBox(height: 10));
      widgetList.add(Align(
        alignment: Alignment.topLeft,
        child: Text(
          result.description,
          style: TextStyle(fontSize: 12),
        ),
      ));
    }

    return Card(
      color: result.correct || result.answer == quiz.correctAnswer
          ? Colors.green[100]
          : Colors.red[100],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Column(children: widgetList),
            if (!result.graded)
              Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.hourglass_bottom,
                  color: Color(0x66000000),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
