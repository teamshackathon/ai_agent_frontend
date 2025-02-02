// import 'package:code/data/firebase/lesson_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/during_stream.dart';
import 'package:code/widget/tools/lesson_start_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

/// hotreloadの際は一度mainに帰って
class TeacherTools extends StatelessWidget {
  const TeacherTools({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "教師機能選択",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: TeacherToolsDisplay(
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
        ),
      ),
    );
  }
}

class TeacherToolsDisplay extends ConsumerWidget {
  const TeacherToolsDisplay({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
  });

  final double displayWidth, displayHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: LessonStartSlide(),
        ),
        Column(
          children: [
            InkWell(
              onTap: () {
                GoRouter.of(context).push(Routes.teacherAgenda);
              },
              child: ListTile(
                title: Card(
                  child: Column(
                    children: [
                      Text(""),
                      Text("授業内容"),
                      Text(""),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                GoRouter.of(context).push(Routes.teacherQuiz);
              },
              child: ListTile(
                title: Card(
                  child: Column(
                    children: [
                      Text(""),
                      Text("小テストの確認"),
                      Text(""),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Card(
                  child: Column(
                    children: [
                      Text(""),
                      Text("宿題"),
                      Text(""),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
