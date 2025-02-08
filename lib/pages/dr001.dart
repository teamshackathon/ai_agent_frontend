import 'package:code/data/quiz/quiz.dart';
import 'package:code/dummy/data/dummy_provider.dart';
import 'package:code/dummy/widget/dummy_base_page.dart';
import 'package:code/toast.dart';
import 'package:code/widget/quiz/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          //quizNot.init(readQuiz("mock"));
          infoToast(log: quiz.toString());
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
