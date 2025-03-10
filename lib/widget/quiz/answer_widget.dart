import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/quiz/quiz.dart';
import '../quiz_materials/answer_textfield.dart';
import '../quiz_materials/quiz_text.dart';
import '../quiz_materials/radio_button.dart';
import '../quiz_materials/result_and_correct.dart';

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
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        QuizText(quizText: quiz.question),
        AnswerTextboxResult(answer: quiz.answer),
        ResultAndCorrect(
          result: quiz.correct,
          score: quiz.score,
          correctAnswer: quiz.correctAnswer,
        )
      ],
    );
  }
}
