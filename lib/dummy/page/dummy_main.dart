import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/quiz/quiz.dart';
import '../../widget/quiz/answer_widget.dart';
import '../data/dummy_provider.dart';
import '../widget/dummy_base_page.dart';

class DummyMain extends ConsumerWidget {
  const DummyMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);
    dummyNot.state = true;
    final quizNot = ref.read(quizNotifierProvider.notifier);
    final quiz = ref.watch(quizNotifierProvider);

    return DummyBasePage(
      floatingActionButton: FloatingActionButton(onPressed: () {
        quizNot.init(readQuiz("mock"));
        infoToast(log: quiz.toString());
      }),
      pageTitle: "ダミーメイン",
      body: ListView.builder(
        itemCount: quiz.length,
        itemBuilder: (context, index) => AnswerResultWidget(
          quiz: quiz[index],
        ),
      ),
    );
  }
}
