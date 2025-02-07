import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';
import '../../../../widget/teacher_tools/edit_agenda_action_button.dart';
import '../../../../widget/teacher_tools/teacher_agenda_sentence_card.dart';
import '../../../../widget/utils/lesson_slide.dart';

class TeacherAgenda extends StatelessWidget {
  const TeacherAgenda({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 透明
      backgroundColor: Colors.transparent,
      body: TeacherAgendaDisplay(lesson: lesson),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            LessonSlide(lesson: lesson),
            Spacer(),
            SizedBox(
              width: 55,
              height: 55,
              child: Visibility(
                visible: lesson.state == "before",
                child: EditAgendaActionButton(lesson: lesson),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherAgendaDisplay extends HookConsumerWidget {
  const TeacherAgendaDisplay({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agenda = lesson.agendaPublish;

    return Padding(
      padding: EdgeInsets.only(top: 10),
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
    );
  }
}
