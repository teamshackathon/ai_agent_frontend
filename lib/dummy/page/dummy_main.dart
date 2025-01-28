import 'package:code/data/quiz/quiz.dart';
import 'package:code/widget/quiz/answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../widget/dummy_base_page.dart';
import '../../widget/sakura_redial_menu/radial_menu.dart';
import '../../../toast.dart';

void onItemSelected(dynamic value) {
  print(value);
  infoToast(toast: "$value", log: "ログイン成功");
}

class DummyMain extends ConsumerWidget {
  DummyMain({super.key});

  final GlobalKey<RadialSakuraMenuState> _menuKey =
      GlobalKey<RadialSakuraMenuState>();

  final List<RadialSakuraMenuItem> items = <RadialSakuraMenuItem>[
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.japanese,
      angle: 0.0,
      onPressed: () => onItemSelected("japanese"),
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.english,
      angle: 2 * math.pi / 5 * 1,
      onPressed: () => onItemSelected("english"),
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.social,
      angle: 2 * math.pi / 5 * 2,
      onPressed: () => onItemSelected("social"),
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.science,
      angle: 2 * math.pi / 5 * 3,
      onPressed: () => onItemSelected("science"),
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.math,
      angle: 2 * math.pi / 5 * 4,
      onPressed: () => onItemSelected("math"),
    ),
  ];

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
      pageTitle: "ダミープロフィール",
      body: Scaffold(
        body: RadialSakuraMenu(
          key: _menuKey,
          items: items,
          radius: 100.0,
          onSelected: onItemSelected,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.restore),
          onPressed: () {
            if (_menuKey.currentState != null) {
              if (_menuKey.currentState!.isOpen) {
                _menuKey.currentState?.closeMenu();
              } else {
                _menuKey.currentState?.openMenu();
              }
            }
          },
        ),
      ),
    );
  }
}
*/
