import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/firebase/tools_stream.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../widget/utils/sakura_progress_indicator.dart';
import 'tools/student_agenda.dart';
import 'tools/student_answer_check.dart';
import 'tools/student_homework.dart';

/// hotreloadの際は一度mainに帰って
class StudentTools extends ConsumerWidget {
  const StudentTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(toolsStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);
    final currentLesson = ref.watch(currentLessonProvider);
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "第${currentLesson.count}回 ${currentRoom.displaySubject}",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: lessonStream.when(
            data: (lesson) =>
                StudentToolsDisplay(lesson: lesson.data() ?? Lesson.isBlank()),
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

class StudentToolsDisplay extends HookConsumerWidget {
  const StudentToolsDisplay({super.key, required this.lesson});

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
              Text(
                lesson.agendaPublish.title,
                maxLines: null,
              ),
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
          StudentAgenda(lesson: lesson),
          StudentAnswerCheck(lesson: lesson),
          StudentHomework(lesson: lesson),
        ],
      )),
    ]);
  }
}
