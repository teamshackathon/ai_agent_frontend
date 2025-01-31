import 'package:code/data/quiz/quiz.dart';
import 'package:code/dummy/widget/dummy_base_page.dart';
import 'package:code/widget/quiz/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Tq001 extends HookConsumerWidget {
  const Tq001({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizNot = ref.read(quizNotiferProvider.notifier);
    final quiz = ref.watch(quizNotiferProvider);

    return DummyBasePage(
      floatingActionButton:
          FloatingActionButton(onPressed: () => quizNot.init(readQuiz("mock"))),
      pageTitle: "ダミーメイン",
      body: ListView.builder(
        itemCount: quiz.length,
        itemBuilder: (context, index) => AnswerWidget(
          quiz: quiz[index],
          onChanged: (value) => quizNot.writeAnswer(quiz[index].title, value),
        ),
      ),
    );
  }
}
