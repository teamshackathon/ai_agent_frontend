import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/lesson/lesson.dart';
import '../teacher_tools/teacher_agenda_sentence_card.dart';

class _TeacherAgendaDisplay extends HookConsumerWidget {
  const _TeacherAgendaDisplay({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agenda = lesson.agendaDraft;

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
      ),
    );
  }
}
