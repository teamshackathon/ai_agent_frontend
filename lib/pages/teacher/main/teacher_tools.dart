import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/tools_stream.dart';
import '../../../data/lesson/lesson.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/teacher_tools/teacher_homework_tab_bar_view.dart';
import '../../../widget/utils/sakura_progress_indicator.dart';
import 'tools/teacher_agenda.dart';
import 'tools/teacher_quiz.dart';

/// hotreloadの際は一度mainに帰って
class TeacherTools extends ConsumerWidget {
  const TeacherTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(currentLessonProvider);
    final lessonStream = ref.watch(toolsStreamProvider);
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "第${current.count}回",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: lessonStream.when(
            data: (lesson) =>
                TeacherToolsDisplay(lesson: lesson.data() ?? Lesson.isBlank()),
            // エラー時の表示
            error: (_, __) => const Center(
              child: Text("読み込み失敗"),
            ),
            // 読込中の表示
            loading: () => const Center(
              child: SakuraProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class TeacherToolsDisplay extends HookWidget {
  const TeacherToolsDisplay({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 3);

    return Column(
      children: [
        Text(
          lesson.agendaPublish.title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          softWrap: false,
        ),
        TabBar(controller: tabController, tabs: [
          Tab(text: "授業内容"),
          Tab(text: "テスト"),
          Tab(text: "宿題"),
        ]),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            TeacherAgenda(lesson: lesson),
            TeacherQuiz(lesson: lesson),
            TeacherHomeworkTabBarView(),
          ],
        )),
      ],
    );
  }
}
