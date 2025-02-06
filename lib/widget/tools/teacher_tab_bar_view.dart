import 'package:code/data/agenda/agenda.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/quiz/quiz.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/lesson/lesson.dart';
import '../../widget/agenda_materials/agenda_editor_field.dart';
import '../../widget/agenda_materials/sentence_card.dart';
import '../../../route/route.dart';

class TeacherAgendaTabBarView extends HookConsumerWidget {
  const TeacherAgendaTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();

    return Scaffold(
      // 透明
      backgroundColor: Colors.transparent,
      body: TeacherAgendaDisplay(lesson: lesson),
      floatingActionButton: EditAgendaActionButton(
        lesson: lesson,
      ),
    );
  }
}

class EditAgendaActionButton extends HookConsumerWidget {
  const EditAgendaActionButton({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final agendaState = useState<Agenda>(lesson.agendaDraft);

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: true,
              initialChildSize: 1,
              minChildSize: 0.5,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '授業資料の編集',
                              style: TextStyle(
                                fontSize: 20,
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
                        const SizedBox(height: 16),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await reference.update({
                                    "agenda_draft": agendaState.value.toMap()
                                  });
                                },
                                child: Text("下書き保存"),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await reference.update({
                                    "agenda_draft": agendaState.value.toMap()
                                  });
                                  await reference.update({
                                    "agenda_publish": agendaState.value.toMap()
                                  });
                                  ;
                                },
                                child: Text("公開"),
                              ),
                            ),
                          ],
                        ),
                        // 他のウィジェットをここに追加
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text("タイトル"),
                        ),
                        AgendaEditorField(
                          initialValue: agendaState.value.title,
                          onChanged: (str) {
                            agendaState.value =
                                agendaState.value.copyWith(title: str);
                          },
                          editable: true,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: agendaState.value.sentences.length,
                          itemBuilder: (context, index) {
                            return SentenceCard(
                              editable: true,
                              sentence: agendaState.value.sentences[index],
                              onChanged: (sentence) {
                                var list = [
                                  for (var i = 0;
                                      i < agendaState.value.sentences.length;
                                      i++)
                                    i == index
                                        ? sentence
                                        : agendaState.value.sentences[i]
                                ];
                                agendaState.value =
                                    agendaState.value.copyWith(sentences: list);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.edit),
          Text("編集"),
        ],
      ),
    );
  }
}

class TeacherAgendaDisplay extends HookConsumerWidget {
  const TeacherAgendaDisplay({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agenda = lesson.agendaPublish;

    return Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: agenda.sentences.isEmpty
                  ? Text("まだ公開されていません")
                  : ListView.builder(
                      itemCount: agenda.sentences.length,
                      itemBuilder: (context, index) {
                        return TeacherAgendaSentenceCard(
                          sentence: agenda.sentences[index],
                          index: index,
                        );
                      },
                    ),
            ),
          ],
        ));
  }
}

class TeacherAgendaSentenceCard extends ConsumerWidget {
  const TeacherAgendaSentenceCard({
    super.key,
    required this.sentence,
    required this.index,
  });
  final Sentence sentence;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(0),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      (index + 1).toString().padLeft(2, "0"),
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(sentence.subtitle,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Container(
                          width: 20,
                        ),
                        Text("${sentence.time.toString()}分"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 55,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sentence.description,
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          )
        ]));
  }
}

class TeacherQuizTabBarView extends HookConsumerWidget {
  const TeacherQuizTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();

    return Scaffold(
      // 透明
      backgroundColor: Colors.transparent,
      body: TeacherQuizDisplay(lesson: lesson),
      floatingActionButton: EditQuizActionButton(
        lesson: lesson,
      ),
    );
  }
}

class TeacherQuizDisplay extends HookConsumerWidget {
  const TeacherQuizDisplay({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final quizzes = useState<List<Quiz>>(lesson.questionsPublish);

    return ListView.builder(
      itemCount: quizzes.value.length,
      itemBuilder: (context, index) {
        final quiz = quizzes.value[index];
        return Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(0),
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 10),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          (index + 1).toString().padLeft(2, "0"),
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            quiz.question,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 10,
              ),
              if (quiz is Kijutsu) Text("問題形式: 記述式"),
              if (quiz is Anaume) Text("問題形式: 穴埋め"),
              if (quiz is Sentaku) Text("問題形式: 選択式"),
              if (quiz is Sentaku)
                Text("選択肢: ${quiz.options.map((e) => e.word).join(", ")}"),
              Text("正解: ${quiz.correctAnswer}"),
              Text("スコア: ${quiz.score}"),
            ]));
      },
    );
  }
}

class EditQuizActionButton extends HookConsumerWidget {
  const EditQuizActionButton({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final questionState = useState(lesson.questionsDraft);

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: true,
              initialChildSize: 1,
              minChildSize: 0.5,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'テストの編集',
                              style: TextStyle(
                                fontSize: 20,
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
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.edit),
          Text("編集"),
        ],
      ),
    );
  }
}

class TeacherStudentStudyTabBarView extends HookConsumerWidget {
  const TeacherStudentStudyTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentroom = ref.watch(currentRoomProvider);
    final students = currentroom.students;
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Row(
          children: [
            Text(student),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: Text("テスト結果"),
            ),
            ElevatedButton(onPressed: () {}, child: Text("宿題の確認"))
          ],
        );
      },
    );
  }
}
