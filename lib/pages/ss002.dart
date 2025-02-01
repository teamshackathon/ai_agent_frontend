import 'package:code/data/quiz/quiz.dart';
import 'package:code/dummy/data/dummy_provider.dart';
import 'package:code/dummy/widget/dummy_base_page.dart';
import 'package:code/widget/quiz/quiz_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PreviewAnswer extends ConsumerWidget {
  const PreviewAnswer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);
    dummyNot.state = true;
    final quizNot = ref.read(quizNotifierProvider.notifier);
    final quiz = ref.watch(quizNotifierProvider);

    return DummyBasePage(
      floatingActionButton:
          FloatingActionButton(onPressed: () => quizNot.init(readQuiz("mock"))),
      pageTitle: "ダミーメイン",
      body: ListView.builder(
        itemCount: quiz.length,
        itemBuilder: (context, index) => QuizEditWidget(
          quiz: quiz[index],
          onChanged: (value) => quizNot.replaceQuiz(value),
          editable: true,
        ),
      ),
    );
  }
}
