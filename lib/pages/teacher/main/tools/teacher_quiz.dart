import 'dart:ui';

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
  const TeacherQuiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: TeacherQuizScreen(
          lesson: lesson,
          displayWidth: size.width * widthFactor,
          displayHeight: size.height * widthFactor,
        ),
      ),
    );
  }
}

class TeacherQuizScreen extends HookConsumerWidget {
  const TeacherQuizScreen({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
    required this.lesson,
  });

  final double displayWidth, displayHeight;
  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draggable = ref.watch(draggableProvider);
    final draggableNot = ref.read(draggableProvider.notifier);
    final currentRoom = ref.watch(currentRoomProvider);

    useEffect(() {
      return;
    }, []);

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
            QuizSubmissionDisplay(lesson: lesson),
          ],
          onPageChanged: (page) async {
            if (page == 1) {
              await startTestToDuring(
                teacher: currentRoom.teacher,
                currentLesson: lesson,
              );
              draggableNot.state = false;
            }
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

    return Column(
      children: [
        Flexible(
          child: ListView.builder(
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
          ),
        ),
        Visibility(
          visible: !draggable,
          child: ElevatedButton(
            onPressed: () async {
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
            },
            child: drafting.value ? Text("下書き保存") : Text("保存"),
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

class QuizSubmissionDisplay extends ConsumerWidget {
  const QuizSubmissionDisplay({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(submissionStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);

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
            Text("テスト中 : ${currentRoom.students.length - count}"),
            Text("提出済み : ${count - finish}"),
            Text("採点済み : $finish"),
            ElevatedButton(
              onPressed: () async {
                await finishLessonToDuring(
                  teacher: currentRoom.teacher,
                  currentLesson: lesson,
                );
                if (context.mounted) {
                  GoRouter.of(context).pop();
                }
              },
              child: Text("テスト終了"),
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
