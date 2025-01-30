import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/tool_stream.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/lesson/lesson.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/lessons/components/lesson_card.dart';
import '../../../widget/lessons/components/lessons_summary.dart';

class StudentLessons extends ConsumerWidget {
  const StudentLessons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(lessonStreamProvider);

    return BasePage(
      pageTitle: "生徒コマ選択",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: lessonStream.when(
            data: (snapshot) => StudentLessonsDisplay(lessons: snapshot.docs),
            // エラー時の表示
            error: (_, __) => const Center(child: Text("読み込み失敗")),
            // 読込中の表示
            loading: () => const Center(child: CircularProgressIndicator()),
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
    final currentLessonRefNot = ref.read(currentLessonRefProvider.notifier);

    return lessons.isEmpty
        ? Center(child: Text("授業がありません"))
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: LessonsSummary(),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index].data();
                  return LessonCard(
                    lesson: lesson,
                    onTap: () {
                      currentLessonRefNot.state = lesson.reference;
                      GoRouter.of(context).push(Routes.studentTools);
                    },
                  );
                },
              ))
            ],
          );
  }
}
