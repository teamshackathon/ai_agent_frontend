import 'package:code/widget/quiz/quiz_edit_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/quiz/quiz.dart';
import '../data/dummy_provider.dart';
import '../widget/dummy_base_page.dart';

class DummyMain extends ConsumerWidget {
  const DummyMain({super.key});

  // final List<RadialSakuraMenuItem> items = <RadialSakuraMenuItem>[
  //   RadialSakuraMenuItem(
  //     key: UniqueKey(),
  //     value: MenuOptions.japanese,
  //     angle: 0.0,
  //     onPressed: () => onItemSelected("japanese"),
  //   ),
  //   RadialSakuraMenuItem(
  //     key: UniqueKey(),
  //     value: MenuOptions.english,
  //     angle: 2 * math.pi / 5 * 1,
  //     onPressed: () => onItemSelected("english"),
  //   ),
  //   RadialSakuraMenuItem(
  //     key: UniqueKey(),
  //     value: MenuOptions.social,
  //     angle: 2 * math.pi / 5 * 2,
  //     onPressed: () => onItemSelected("social"),
  //   ),
  //   RadialSakuraMenuItem(
  //     key: UniqueKey(),
  //     value: MenuOptions.science,
  //     angle: 2 * math.pi / 5 * 3,
  //     onPressed: () => onItemSelected("science"),
  //   ),
  //   RadialSakuraMenuItem(
  //     key: UniqueKey(),
  //     value: MenuOptions.math,
  //     angle: 2 * math.pi / 5 * 4,
  //     onPressed: () => onItemSelected("math"),
  //   ),
  // ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);
    dummyNot.state = true;
    final quizNot = ref.read(quizNotiferProvider.notifier);
    final quiz = ref.watch(quizNotiferProvider);

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
