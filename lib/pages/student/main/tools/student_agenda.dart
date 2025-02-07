import 'package:flutter/material.dart';

import '../../../../data/lesson/lesson.dart';
import '../../../../widget/student_tools/student_agenda_sentence_card.dart';

class StudentAgenda extends StatelessWidget {
  const StudentAgenda({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final agenda = lesson.agendaPublish;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: agenda.sentences.isEmpty
            ? Center(child: Text("まだ公開されていません"))
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
    );
  }
}
