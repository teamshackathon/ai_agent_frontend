import 'package:code/data/quiz/quiz.dart';
import 'package:code/widget/quiz/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widget/dummy_base_page.dart';

class DummyMain extends HookConsumerWidget {
  const DummyMain({super.key});

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

/*
class DummyMain extends ConsumerStatefulWidget {
  const DummyMain({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DummyMainState();
}

class _DummyMainState extends ConsumerState<DummyMain> {
  void initialize(WidgetRef ref) {
    setState(() {
      ref.read(quizNotiferProvider.notifier).init(readQuiz("mock"));
    });
  }

  @override
  void initState() {
    initialize(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizNotiferProvider);

    return DummyBasePage(
      pageTitle: "ダミーメイン",
      body: Center(
        child: Text(quiz[0].question),
      ),
    );
  }
}
*/
