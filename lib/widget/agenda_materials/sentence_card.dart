import 'package:code/widget/agenda_materials/agenda_editor_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/agenda/agenda.dart';

class SentenceCard extends ConsumerWidget {
  const SentenceCard(
      {super.key,
      required this.sentence,
      required this.onChanged,
      required this.editable});
  final Sentence sentence;
  final ValueChanged<Sentence> onChanged;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      child: Card(
        child: Column(
          children: [
            SizedBox(
              child: Row(
                children: [
                  Flexible(
                    flex: 20,
                    child: AgendaEditorField(
                      editable: editable,
                      initialValue: sentence.subtitle,
                      onChanged: (str) {
                        onChanged(sentence.copyWith(subtitle: str));
                      },
                    ),
                  ),
                  Spacer(flex: 10),
                  Flexible(
                    flex: 5,
                    child: AgendaEditorField(
                      editable: editable,
                      textAlign: TextAlign.right,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      initialValue: sentence.time.toString(),
                      onChanged: (str) {
                        onChanged(sentence.copyWith(time: int.parse(str)));
                      },
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Text("分"),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: AgendaEditorField(
                editable: editable,
                maxLines: null,
                initialValue: sentence.description,
                onChanged: (str) {
                  onChanged(sentence.copyWith(description: str));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
