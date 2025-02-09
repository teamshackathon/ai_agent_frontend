import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/quiz/quiz.dart';
import '../dummy/data/dummy_provider.dart';
import '../dummy/widget/dummy_base_page.dart';
import '../widget/quiz/answer_widget.dart';

class DisplayResult extends ConsumerWidget {
  const DisplayResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);
    dummyNot.state = true;
    final quizNot = ref.read(quizNotifierProvider.notifier);
    final quiz = ref.watch(quizNotifierProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: DummyBasePage(
        floatingActionButton: FloatingActionButton(onPressed: () {

        }),
        pageTitle: "ダミーメイン",
        body: ListView.builder(
          itemCount: quiz.length,
          itemBuilder: (context, index) => AnswerResultWidget(
            quiz: quiz[index],
          ),
        ),
      )),
    );
  }
}
