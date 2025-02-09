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
import '../../../../data/submission/submission.dart';
import '../../../../toast.dart';
import '../../../../widget/quiz/quiz_edit_widget.dart';
import '../../../../widget/utils/loading_button.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';
import '../../../student/main/tools/student_answer_check.dart';
import 'quiz_submission_display.dart';

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
        widget = QuizResultsDisplay(lesson: lesson);
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
    final draggableNot = ref.read(draggableProvider.notifier);
    final currentRoom = ref.watch(currentRoomProvider);

    return ScrollConfiguration(
      // chrome上でスワイプを検知するために必要、実機ではいらない
      behavior: _MouseDraggableScrollBehavior(),
      child: PageView(
        physics: draggable ? null : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          QuizEditDisplay(lesson: lesson),
          SizedBox(),
        ],
        onPageChanged: (page) async {
          draggableNot.state = false;
          await startTestToDuring(
            teacher: currentRoom.teacher,
            reference: lesson.reference,
          );
        },
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

    return lesson.questionsDraft.isNotEmpty
        ? Column(
            children: [
              Flexible(
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
                    index: index,
                  ),
                  separatorBuilder: (context, index) => Divider(height: 2),
                ),
              ),
              Visibility(
                visible: !draggable,
                child: SizedBox(height: 8),
              ),
              Visibility(
                visible: !draggable,
                child: LoadingButton(
                  width: 160,
                  height: 35,
                  onPressed: () async {
                    loading.value = true;
                    if (drafting.value) {
                      await reference.update({
                        "questions_draft": [
                          for (var q in quizzes.value) q.toMap()
                        ]
                      });
                      drafting.value = false;
                    } else {
                      await reference.update({
                        "questions_publish": [
                          for (var q in quizzes.value) q.toMap()
                        ]
                      });
                      draggableNot.state = true;
                    }
                    loading.value = false;
                  },
                  isLoading: loading.value,
                  text: drafting.value ? "下書き保存" : "保存",
                ),
              ),
              Visibility(visible: !draggable, child: SizedBox(height: 2)),
              Visibility(
                visible: draggable,
                child: Text(
                  "上にスワイプしてテスト開始",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          )
        : const Center(child: SakuraProgressIndicator());
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
        final count = currentRoom.students.length;
        final submissions = snapshot.docs;
        final List<Submission> busy = [];
        final List<Submission> finish = [];
        for (final s in submissions) {
          if (s.data().testResults.first.graded) {
            finish.add(s.data());
          } else {
            busy.add(s.data());
          }
        }
        final testing = count - busy.length - finish.length;

        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(height: 2),
          ),
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: Color(0xFFEEDDDD),
              collapsedBackgroundColor: Color(0xFFEEDDDD),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("テスト中", style: TextStyle(fontSize: 20)),
                  Text("$testing", style: TextStyle(fontSize: 20)),
                ],
              ),
              children: [],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(height: 2),
          ),
          TeacherSubmissionsExpansionTile(
            lesson: lesson,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("採点中", style: TextStyle(fontSize: 20)),
                Text("${busy.length}", style: TextStyle(fontSize: 20)),
              ],
            ),
            submissions: busy,
            color: Color(0xFFEEEEDD),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(height: 2),
          ),
          TeacherSubmissionsExpansionTile(
            lesson: lesson,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("採点中", style: TextStyle(fontSize: 20)),
                Text("${finish.length}", style: TextStyle(fontSize: 20)),
              ],
            ),
            submissions: finish,
            color: Color(0xFFDDEEDD),
          ),
          Spacer(),
          LoadingButton(
            width: 200,
            onPressed: () async {
              loading.value = true;
              await finishLessonToDuring(
                teacher: currentRoom.teacher,
                reference: lesson.reference,
              );
              if (context.mounted) {
                GoRouter.of(context).pop();
              }
              loading.value = false;
            },
            isLoading: loading.value,
            text: "テスト終了",
          ),
        ]);
      },
      // エラー時の表示
      error: (_, __) => const Text("読み込み失敗"),
      // 読込中の表示
      loading: () => const SakuraProgressIndicator(),
    );
  }
}

class QuizResultsDisplay extends ConsumerWidget {
  const QuizResultsDisplay({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(submissionStreamProvider);

    return results.when(
      data: (snapshot) {
        final submissions = snapshot.docs;
        final List<Widget> list = [];

        for (var sub in submissions) {
          list.add(ListTile(
            title: Text(sub.data().name, style: TextStyle(fontSize: 20)),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "  ${sub.data().name}",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        Expanded(
                          child: FractionallySizedBox(
                            widthFactor: 0.95,
                            heightFactor: 0.95,
                            child: StudentAnswerCheckDisplay(
                              lesson: lesson,
                              submission: sub.data(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ));
        }

        return ListView(children: list);
      },
      // エラー時の表示
      error: (_, __) => const Text("読み込み失敗"),
      // 読込中の表示
      loading: () => const SakuraProgressIndicator(),
    );
  }
}
