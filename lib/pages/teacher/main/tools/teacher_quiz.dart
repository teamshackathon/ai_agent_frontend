import 'dart:ui';

import 'package:code/widget/utils/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/during_stream.dart';
import '../../../../data/firebase/lesson_stream.dart';
import '../../../../data/firebase/submission_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../data/quiz/quiz.dart';
import '../../../../toast.dart';
import '../../../../widget/quiz/quiz_edit_widget.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

final draggableProvider = StateProvider<bool>((ref) => false);

class TeacherQuiz extends ConsumerWidget {
  const TeacherQuiz({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget widget;

    switch (lesson.state) {
      case "before":
        widget = Text("授業終了時に生成されます");
      case "lesson":
        widget = Text("授業終了時に生成されます");
      case "break":
        widget = QuizEditScreen(lesson: lesson);
      case "test":
        widget = QuizSubmissionDisplay(lesson: lesson);
      case "after":
        widget = Text("生徒たちの成績");
      default:
        widget = Text("読み込み失敗");
    }

    return Center(child: widget);
  }
}

class QuizEditScreen extends HookConsumerWidget {
  const QuizEditScreen({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draggable = ref.watch(draggableProvider);
    final currentRoom = ref.watch(currentRoomProvider);

    return Center(
      child: ScrollConfiguration(
        // chrome上でスワイプを検知するために必要、実機ではいらない
        behavior: _MouseDraggableScrollBehavior(),
        child: PageView(
          // controller: PageController(initialPage: ),
          physics: draggable ? null : const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            QuizEditDisplay(lesson: lesson),
            SizedBox(),
          ],
          onPageChanged: (page) async {
            await startTestToDuring(
              teacher: currentRoom.teacher,
              currentLesson: lesson,
            );
          },
        ),
      ),
    );
  }
}

class _MouseDraggableScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class QuizEditDisplay extends HookConsumerWidget {
  const QuizEditDisplay({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final quizzes = useState<List<Quiz>>(lesson.questionsDraft);
    final drafting = useState<bool>(false);
    final draggable = ref.watch(draggableProvider);
    final draggableNot = ref.read(draggableProvider.notifier);
    final loading = useState<bool>(false);

    return Column(
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ListView.separated(
              itemCount: quizzes.value.length,
              itemBuilder: (context, index) => QuizEditWidget(
                quiz: quizzes.value[index],
                onChanged: (quiz) {
                  infoToast(log: "before : ${quizzes.value}");
                  var list = [
                    for (var i = 0; i < quizzes.value.length; i++)
                      i == index ? quiz : quizzes.value[i]
                  ];
                  quizzes.value = list;
                  drafting.value = true;
                  draggableNot.state = false;
                  infoToast(log: "after : ${quizzes.value}");
                },
                editable: true,
              ),
              separatorBuilder: (context, index) => Divider(height: 2),
            ),
          ),
        ),
        SizedBox(height: 10),
        Visibility(
          visible: !draggable,
          child: LoadingButton(
            width: 160,
            onPressed: () async {
              loading.value = true;
              if (drafting.value) {
                await reference.update({
                  "questions_draft": [for (var q in quizzes.value) q.toMap()]
                });
                drafting.value = false;
              } else {
                await reference.update({
                  "questions_publish": [for (var q in quizzes.value) q.toMap()]
                });
                draggableNot.state = true;
              }
              loading.value = false;
            },
            isLoading: loading.value,
            text: drafting.value ? "下書き保存" : "保存",
          ),
        ),
        Visibility(
          visible: draggable,
          child: Text("上にスワイプしてテスト開始"),
        ),
      ],
    );
  }
}

class QuizSubmissionDisplay extends HookConsumerWidget {
  const QuizSubmissionDisplay({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(submissionStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);
    final loading = useState<bool>(false);

    return results.when(
      data: (snapshot) {
        final count = snapshot.size;
        final submission = snapshot.docs;
        var finish = 0;
        for (var s in submission) {
          if (s.data().testResults != [] &&
              s.data().testResults[0].description != "") {
            finish++;
          }
        }

        return Center(
          child: Column(children: [
            Spacer(),
            Text("テスト中 : ${currentRoom.students.length - count}"),
            Text("提出済み : ${count - finish}"),
            Text("採点済み : $finish"),
            Spacer(),
            LoadingButton(
              width: 200,
              onPressed: () async {
                loading.value = true;
                await finishLessonToDuring(
                  teacher: currentRoom.teacher,
                  currentLesson: lesson,
                );
                if (context.mounted) {
                  GoRouter.of(context).pop();
                }
                loading.value = false;
              },
              isLoading: loading.value,
              text: "テスト終了",
            ),
          ]),
        );
      },
      // エラー時の表示
      error: (_, __) => const Center(
        child: Text("読み込み失敗"),
      ),
      // 読込中の表示
      loading: () => const Center(
        child: SakuraProgressIndicator(),
      ),
    );
  }
}
