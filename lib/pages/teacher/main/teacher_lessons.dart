import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/agenda/agenda.dart';
import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/lesson/lesson.dart';
import '../../../data/quiz/quiz.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class TeacherLessons extends ConsumerWidget {
  const TeacherLessons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonsStream = ref.watch(lessonsStreamProvider);

    return BasePage(
      pageTitle: "教師コマ選択",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: lessonsStream.when(
            data: (snapshot) => TeacherLessonsDisplay(lessons: snapshot.docs),
            // エラー時の表示
            error: (_, __) => const Center(
              child: Text("読み込み失敗"),
            ),
            // 読込中の表示
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class TeacherLessonsDisplay extends HookConsumerWidget {
  const TeacherLessonsDisplay({super.key, required this.lessons});

  final List<QueryDocumentSnapshot<Lesson>> lessons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLessonNot = ref.read(currentLessonProvider.notifier);
    final currentRoom = ref.watch(currentRoomProvider);
    final disable = useState<bool>(false);

    return Column(
      children: [
        Flexible(
          flex: 20,
          child: InkWell(
            onTap: () async {
              disable.value = true;
              infoToast(log: currentRoom.toString());
              await currentRoom.reference.add(
                Lesson(
                  count: lessons.length + 1,
                  agendaPublish: Agenda.isBlank(),
                  agendaDraft: Agenda.isBlank(),
                  questionsPublish: Quiz.isBlank(),
                  questionsDraft: Quiz.isBlank(),
                  reference: currentRoom.reference.doc(),
                ).toMap(),
              );
              disable.value = false;
            },
            child: Card(
              child: Center(
                child: Text("新規授業作成"),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: SizedBox(height: 10),
        ),
        Flexible(
          flex: 70,
          child: lessons.isEmpty
              ? Center(child: Text("授業がありません"))
              : ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    final lesson = lessons[index].data();
                    return InkWell(
                      onTap: () async {
                        currentLessonNot.state = lessons[index];
                        GoRouter.of(context).push(Routes.teacherTools);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Text(""),
                            Text("第${lesson.count}回"),
                            Text(""),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
