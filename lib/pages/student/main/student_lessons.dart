import 'package:code/data/firebase/tool_stream.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class StudentLessons extends ConsumerWidget {
  const StudentLessons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(lessonStreamProvider);
    final currentLessonRefNot = ref.read(currentLessonRefProvider.notifier);

    return BasePage(
      pageTitle: "生徒コマ選択",
      body: lessonStream.when(
        data: (snapshot) {
          final lessons = snapshot.docs;
          if (lessons.isEmpty) {
            return Center(child: Text("授業がありません"));
          }
          return Center(
            child: FractionallySizedBox(
              widthFactor: 0.95,
              heightFactor: 0.95,
              child: ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index].data();
                  return InkWell(
                    onTap: () async {
                      currentLessonRefNot.state = lesson.reference;
                      GoRouter.of(context).push(Routes.studentTools);
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
          );
        },
        // エラー時の表示
        error: (_, __) => const Center(
          child: Text("読み込み失敗"),
        ),
        // 読込中の表示
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
