import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/firebase/tools_stream.dart';
import '../../../data/lesson/lesson.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/lessons/components/lesson_card.dart';
import '../../../widget/lessons/components/lessons_summary.dart';
import '../../../widget/utils/sakura_progress_indicator.dart';

class StudentLessons extends ConsumerWidget {
  const StudentLessons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsStream = ref.watch(lessonsStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);

    return BasePage(
      pageTitle: "あなたの${currentRoom.displaySubject}の授業",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: lessonsStream.when(
            data: (snapshot) => StudentLessonsDisplay(lessons: snapshot.docs),
            // エラー時の表示
            error: (_, __) => const Center(child: Text("読み込み失敗")),
            // 読込中の表示
            loading: () => const Center(child: SakuraProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class StudentLessonsDisplay extends ConsumerWidget {
  const StudentLessonsDisplay({super.key, required this.lessons});

  final List<QueryDocumentSnapshot<Lesson>> lessons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoom = ref.watch(currentRoomProvider);
    final currentLessonNot = ref.read(currentLessonProvider.notifier);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: LessonsSummary(room: currentRoom),
        ),
        lessons.isEmpty
            ? Center(child: Text("授業がありません"))
            : Expanded(
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index].data();
                    if (lesson.agendaPublish.title == "") {
                      if (lessons.length == 1) {
                        return Center(child: Text("授業がありません"));
                      }
                      return const SizedBox();
                    }

                    return LessonCard(
                      lesson: lesson,
                      angle: 0,
                      subject: currentRoom.subject,
                      onTap: () {
                        currentLessonNot.state = lesson;
                        GoRouter.of(context).push(Routes.studentTools);
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }
}
