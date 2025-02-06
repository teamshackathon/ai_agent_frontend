// import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/lesson/lesson.dart';
import 'package:code/widget/tools/lesson_start_slide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/base_page/base_page.dart';
import '../../../widget/tools/teacher_tab_bar_view.dart';

/// hotreloadの際は一度mainに帰って
class TeacherTools extends ConsumerWidget {
  const TeacherTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();

    return BasePage(
      pageTitle: "第${lesson.count}回",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: TeacherToolsDisplay(),
        ),
      ),
    );
  }
}

class TeacherToolsDisplay extends HookConsumerWidget {
  const TeacherToolsDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();

    return Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: LessonStartSlide(),
        ),
        Text(lesson.agendaPublish.title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        TabBar(controller: tabController, tabs: [
          Tab(text: "授業内容"),
          Tab(text: "テスト"),
          Tab(text: "学び"),
          Tab(
            text: "傾向",
          )
        ]),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            TeacherAgendaTabBarView(),
            TeacherQuizTabBarView(),
            TeacherStudentStudyTabBarView(),
            Text("先生へのフィードバックの表示"),
          ],
        )),
      ],
    );
  }
}
