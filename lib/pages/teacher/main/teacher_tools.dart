import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/tools_stream.dart';
import '../../../data/lesson/lesson.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/teacher_tools/teacher_homework_tab_bar_view.dart';
import '../../../widget/utils/sakura_progress_indicator.dart';
import '../../student/main/tools/student_reading.dart';
import 'tools/teacher_agenda.dart';
import 'tools/teacher_markdown.dart';
import 'tools/teacher_quiz.dart';
import 'tools/teacher_total.dart';

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
    final tabController = useTabController(initialLength: 6, initialIndex: 1);

    return Column(
      children: [
        Wrap(
          children: [
            Text(
              lesson.agendaPublish.title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              maxLines: null,
            ),
          ],
        ),
        TabBar(controller: tabController, tabs: [
          Tab(text: "教科書"),
          Tab(text: "内容"),
          Tab(text: "テスト"),
          Tab(text: "宿題"),
          Tab(text: "集計"),
          Tab(text: "分析"),
        ]),
        Expanded(
            child: TabBarView(
          controller: tabController,
          children: [
            FractionallySizedBox(
              widthFactor: 0.95,
              heightFactor: 0.95,
              child: StudentReadingWidget(
                initial: lesson.startPage,
              ),
            ),
            TeacherAgenda(lesson: lesson),
            TeacherQuiz(lesson: lesson),
            TeacherHomeworkTabBarView(),
            TeacherTotal(lesson: lesson),
            TeacherMarkdown(lesson: lesson),
          ],
        )),
      ],
    );
  }
}
