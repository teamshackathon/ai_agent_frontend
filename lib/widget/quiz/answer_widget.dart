import 'package:code/data/quiz/quiz.dart';
import 'package:code/widget/quiz_materials/answer_textfield.dart';
import 'package:code/widget/quiz_materials/quiz_text.dart';
import 'package:code/widget/quiz_materials/radio_button.dart';
import 'package:code/widget/quiz_materials/result_and_correct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnswerWidget extends HookConsumerWidget {
  const AnswerWidget({
    super.key,
    required this.count,
    required this.quiz,
    required this.onChanged,
  });

  final int count;
  final Quiz quiz;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: quiz.answer);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          spacing: 5,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "  Q$count",
                style: TextStyle(fontSize: 20),
              ),
            ),
            QuizText(quizText: quiz.question),
            formatAnswer(quiz, controller),
          ],
        ),
      ),
    );
  }

  Widget formatAnswer(Quiz quiz, TextEditingController controller) {
    if (quiz is Kijutsu) {
      return AnswerTextbox(
        answer: controller.text,
        onChanged: onChanged,
      );
    } else if (quiz is Anaume) {
      return AnswerTextbox(
        answer: controller.text,
        onChanged: onChanged,
      );
    } else if (quiz is Sentaku) {
      return RadioButton(
        options: quiz.options,
        onChanged: (str) => onChanged(str ?? ""),
        stateText: quiz.answer,
      );
    } else {
      throw FormatException("クイズのフォーマットが正常ではありません。");
    }
  }
}

class AnswerResultWidget extends HookConsumerWidget {
  const AnswerResultWidget({
    super.key,
    required this.quiz,
    required this.count,
  });

  final Quiz quiz;
  final int count;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: quiz.answer);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Column(
          spacing: 5,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "  Q$count : ${quiz.title}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            QuizText(quizText: quiz.question),
            formatAnswer(quiz, controller),
            ResultAndCorrect(
              result: quiz.correct,
              score: quiz.score,
              correctAnswer: quiz.correctAnswer,
            )
          ],
        ),
      ),
    );
  }

  Widget formatAnswer(Quiz quiz, TextEditingController controller) {
    if (quiz is Kijutsu) {
      return AnswerTextboxResult(
        answer: controller.text,
      );
    } else if (quiz is Anaume) {
      return AnswerTextboxResult(
        answer: controller.text,
      );
    } else if (quiz is Sentaku) {
      return AnswerTextboxResult(
        answer: "${answer2no(quiz)}: ${quiz.answer}",
      );
    } else {
      throw FormatException("クイズのフォーマットが正常ではありません。");
    }
  }

  String answer2no(Quiz quiz) {
    for (var op in (quiz as Sentaku).options) {
      if (op.word == quiz.correctAnswer) {
        return op.number.toString();
      }
    }
    return "";
  }
}
