import 'package:code/widget/utils/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/agenda/agenda.dart';
import '../../data/lesson/lesson.dart';
import '../agenda_materials/agenda_editor_field.dart';
import '../agenda_materials/sentence_card.dart';

class EditAgendaActionButton extends StatelessWidget {
  const EditAgendaActionButton({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
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
                    child: EditAgendaDisplay(lesson: lesson),
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

class EditAgendaDisplay extends HookWidget {
  const EditAgendaDisplay({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final reference = lesson.reference;
    final agendaState = useState<Agenda>(lesson.agendaDraft);
    final drafting = useState<bool>(false);
    final loading = useState<bool>(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '授業資料の編集',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 他のウィジェットをここに追加
        Align(alignment: Alignment.bottomLeft, child: Text("タイトル")),
        AgendaEditorField(
          initialValue: agendaState.value.title,
          onChanged: (str) {
            agendaState.value = agendaState.value.copyWith(title: str);
            drafting.value = true;
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
                  for (var i = 0; i < agendaState.value.sentences.length; i++)
                    i == index ? sentence : agendaState.value.sentences[i]
                ];
                agendaState.value = agendaState.value.copyWith(sentences: list);
                drafting.value = true;
              },
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LoadingButton(
            width: 160,
            isLoading: loading.value,
            onPressed: () async {
              loading.value = true;
              if (drafting.value) {
                await reference
                    .update({"agenda_draft": agendaState.value.toMap()});
                drafting.value = false;
              } else {
                await reference
                    .update({"agenda_publish": agendaState.value.toMap()});
              }
              loading.value = false;
            },
            text: drafting.value ? "下書き保存" : "公開",
          ),
        ),
      ],
    );
  }
}
