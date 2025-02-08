import 'package:code/data/quiz/quiz.dart';
import 'package:code/widget/quiz_materials/answer_text_editable.dart';
import 'package:code/widget/quiz_materials/quiz_text.dart';
import 'package:code/widget/quiz_materials/select_list_editable.dart';
import 'package:flutter/material.dart';

class QuizEditWidget extends StatelessWidget {
  const QuizEditWidget({
    super.key,
    required this.editable,
    required this.quiz,
    required this.onChanged,
    required this.index,
  });
  final bool editable;
  final Quiz quiz;
  final ValueChanged<Quiz> onChanged;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.pinkAccent))),
              child: Text("問題 ${index + 1}", style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text("問題文", style: TextStyle(fontSize: 16)),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: QuizTextEditable(
                quizText: quiz.question,
                editable: editable,
                onChanged: (str) => onChanged(quiz.copyWith(question: str)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text("回答", style: TextStyle(fontSize: 16)),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: FormatAnswerEditable(
                quiz: quiz,
                editable: editable,
                onChanged: onChanged,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ));
  }
}

class FormatAnswerEditable extends StatelessWidget {
  const FormatAnswerEditable({
    super.key,
    required this.quiz,
    this.editable = false,
    required this.onChanged,
  });

  final Quiz quiz;
  final bool editable;
  final ValueChanged<Quiz> onChanged;

  @override
  Widget build(BuildContext context) {
    if (quiz is Kijutsu) {
      return AnswerTextEditable(
        correctAnswer: quiz.correctAnswer,
        onChanged: (str) => onChanged(quiz.copyWith(correctAnswer: str)),
        editable: editable,
      );
    } else if (quiz is Anaume) {
      return AnswerTextEditable(
        correctAnswer: quiz.correctAnswer,
        onChanged: (str) => onChanged(quiz.copyWith(correctAnswer: str)),
        editable: editable,
      );
    } else if (quiz is Sentaku) {
      return SelectListEditable(
        correctAnswer: quiz.correctAnswer,
        options: (quiz as Sentaku).options,
        onChanged: (options, correct) => onChanged((quiz as Sentaku)
            .copyWith(options: options, correctAnswer: correct)),
        editable: editable,
      );
    } else {
      throw FormatException("クイズのフォーマットが正常ではありません。");
    }
  }
}
