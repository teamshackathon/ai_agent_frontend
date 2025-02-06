import 'package:code/data/agenda/agenda.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/pages/student/main/tools/student_answer_check.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';

class StudentAgendaTabBarView extends HookConsumerWidget {
  const StudentAgendaTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();

    return StudentAgendaDisplay(lesson: lesson);
  }
}

class StudentAgendaDisplay extends HookConsumerWidget {
  const StudentAgendaDisplay({
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
                        return StudentAgendaSentenceCard(
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

class StudentAgendaSentenceCard extends ConsumerWidget {
  const StudentAgendaSentenceCard({
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

class StudentQuizTabBarView extends HookConsumerWidget {
  const StudentQuizTabBarView({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StudentAnswerCheck(lesson: lesson);
  }
}

class StudentHomeworkTabBarView extends HookConsumerWidget {
  const StudentHomeworkTabBarView({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text("宿題");
  }
}
