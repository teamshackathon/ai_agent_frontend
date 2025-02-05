import 'package:code/data/firebase/lesson_stream.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../widget/base_page/base_page.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../widget/student_tools/student_tab_bar_view.dart';

/// hotreloadの際は一度mainに帰って
class StudentTools extends ConsumerWidget {
  const StudentTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final currentRoom = ref.watch(currentRoomProvider);

    return BasePage(
      pageTitle: "第${lesson.count}回 ${currentRoom.displaySubject}",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: StudentToolsDisplay(lesson: lesson),
        ),
      ),
    );
  }
}

// class HomeworkTabBarView extends HookConsumerWidget {}

class StudentToolsDisplay extends HookConsumerWidget {
  const StudentToolsDisplay({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 3);
    final currentRoom = ref.watch(currentRoomProvider);

    return Column(children: [
      Row(children: [
        Text(
          currentRoom.displaySubject,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 10,
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "第${lesson.count}回",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(lesson.agendaPublish.title),
            ],
          ),
        )
      ]),
      TabBar(
        controller: tabController,
        tabs: [
          Tab(text: "授業資料"),
          Tab(text: "テスト"),
          Tab(text: "宿題"),
        ],
      ),
      Expanded(
          child: TabBarView(
        controller: tabController,
        children: [
          StudentAgendaDisplay(lesson: lesson),
          StudentQuizTabBarView(lesson: lesson),
          Text("宿題"),
        ],
      )),
    ]);
  }
}
