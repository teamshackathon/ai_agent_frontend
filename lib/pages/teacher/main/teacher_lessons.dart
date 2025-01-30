import 'package:code/data/firebase/tool_stream.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class TeacherLessons extends ConsumerWidget {
  const TeacherLessons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(lessonStreamProvider);
    final currentLessonRefNot = ref.read(currentLessonRefProvider.notifier);

    return BasePage(
      pageTitle: "教師コマ選択",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: Column(
            children: [
              Flexible(
                flex: 20,
                child: InkWell(
                  onTap: () async {},
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
                child: lessonStream.when(
                  data: (snapshot) {
                    final lessons = snapshot.docs;
                    if (lessons.isEmpty) {
                      return Center(child: Text("授業がありません"));
                    }
                    return ListView.builder(
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        final lesson = lessons[index].data();
                        return InkWell(
                          onTap: () async {
                            currentLessonRefNot.state = lesson.reference;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
