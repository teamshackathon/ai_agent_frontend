import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/quiz/quiz.dart';
import '../dummy/data/dummy_provider.dart';
import '../dummy/widget/dummy_base_page.dart';
import '../widget/quiz/quiz_edit_widget.dart';

class PreviewAnswer extends ConsumerWidget {
  const PreviewAnswer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);
    dummyNot.state = true;
    final quizNot = ref.read(quizNotifierProvider.notifier);
    final quiz = ref.watch(quizNotifierProvider);

    return DummyBasePage(
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () => quizNot.init(readQuiz("mock"))),
      pageTitle: "ダミーメイン",
      body: ListView.builder(
        itemCount: quiz.length,
        itemBuilder: (context, index) => QuizEditWidget(
          quiz: quiz[index],
          onChanged: (value) => quizNot.replaceQuiz(value),
          editable: true,
          index: index,
        ),
      ),
    );
  }
}
