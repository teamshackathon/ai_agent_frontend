import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/agenda/agenda.dart';
import 'package:code/toast.dart';
import 'package:code/widget/teacher_lessons/teacher_lessons_widget.dart';
import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/lesson/lesson.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/teacher_lessons/new_class_action_button.dart';
import '../../../widget/teacher_lessons/teacher_lessons_widget.dart';

class TeacherLessons extends ConsumerWidget {
  const TeacherLessons({super.key});

  String getGakunenAndClass(String room) {
    return "${room.split("-")[0]}年 ${room.split("-")[1]}組";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsStream = ref.watch(lessonsStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);

    return BasePage(
      pageTitle: "${getGakunenAndClass(currentRoom.roomNumber)}の授業一覧",
      floatingActionButton: NewClassActionButton(),
      body: Stack(
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.95,
              heightFactor: 0.95,
              child: lessonsStream.when(
                data: (snapshot) =>
                    TeacherLessonsDisplay(lessons: snapshot.docs),
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
        ],
      ),
    );
  }
}

class TeacherLessonsDisplay extends HookConsumerWidget {
  const TeacherLessonsDisplay({super.key, required this.lessons});

  final List<QueryDocumentSnapshot<Lesson>> lessons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLessonNot = ref.read(currentLessonStreamProvider.notifier);
    final currentRoom = ref.watch(currentRoomProvider);
    final disable = useState<bool>(false);

    return lessons.isEmpty
        ? Center(child: Text("授業がありません"))
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TeacherLessonsSummary(room: currentRoom),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index].data();
                    return TeacherLessonsCard(
                      lesson: lesson,
                      onTap: () async {
                        currentLessonNot.state = lessons[index];
                        GoRouter.of(context).push(Routes.teacherTools);
                      },
                    );
                  },
                ),
              )
            ],
          );
  }
}
