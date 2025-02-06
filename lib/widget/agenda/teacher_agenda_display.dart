import 'package:code/data/agenda/agenda.dart';
import 'package:code/data/lesson/lesson.dart';
import 'package:code/toast.dart';
import 'package:code/widget/agenda_materials/sentence_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../agenda_materials/agenda_editor_field.dart';

class TeacherAgendaDisplay extends HookConsumerWidget {
  const TeacherAgendaDisplay(
      {super.key,
      required this.displayWidth,
      required this.displayHeight,
      required this.lesson});

  final double displayWidth, displayHeight;
  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final agendaState = useState<Agenda>(lesson.agendaDraft);
    final editable = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            infoToast(log: agendaState.value.toMap());
            await reference.update({"agenda_draft": agendaState.value.toMap()});
          },
          child: Text("下書き保存"),
        ),
        ElevatedButton(
          onPressed: () async {
            infoToast(log: agendaState.value.toMap());
            await reference.update({"agenda_draft": agendaState.value.toMap()});
            await reference
                .update({"agenda_publish": agendaState.value.toMap()});
          },
          child: Text("公開"),
        ),
        SizedBox(height: displayHeight * 0.03),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text("タイトル"),
        ),
        SizedBox(
          width: displayWidth * 0.95,
          height: displayHeight * 0.1,
          child: AgendaEditorField(
            initialValue: agendaState.value.title,
            onChanged: (str) {
              infoToast(log: "before : ${agendaState.value}");
              agendaState.value = agendaState.value.copyWith(title: str);
              infoToast(log: "after : ${agendaState.value}");
            },
            editable: editable.value,
          ),
        ),
        Switch(
          value: editable.value,
          onChanged: (value) {
            editable.value = value;
          },
        ),
        // Expanded(
        //   child: ListView.builder(
        //     itemCount: agendaState.value.sentences.length,
        //     itemBuilder: (context, index) {
        //       return SentenceCard(
        //         editable: editable.value,
        //         displayWidth: displayWidth,
        //         displayHeight: displayHeight,
        //         sentence: agendaState.value.sentences[index],
        //         onChanged: (sentence) {
        //           infoToast(log: "before : ${agendaState.value}");
        //           var list = [
        //             for (var i = 0; i < agendaState.value.sentences.length; i++)
        //               i == index ? sentence : agendaState.value.sentences[i]
        //           ];
        //           agendaState.value =
        //               agendaState.value.copyWith(sentences: list);
        //           infoToast(log: "after : ${agendaState.value}");
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
