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
  });
  final bool editable;
  final Quiz quiz;
  final ValueChanged<Quiz> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        QuizTextEditable(
          quizText: quiz.question,
          editable: editable,
          onChanged: (str) => onChanged(quiz.copyWith(question: str)),
        ),
        SizedBox(height: 30),
        FormatAnswerEditable(
          quiz: quiz,
          editable: editable,
          onChanged: onChanged,
        ),
      ],
    );
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
