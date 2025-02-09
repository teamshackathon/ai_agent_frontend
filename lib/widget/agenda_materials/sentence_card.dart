import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/agenda/agenda.dart';
import 'agenda_editor_field.dart';

class SentenceCard extends ConsumerWidget {
  const SentenceCard(
      {super.key,
      required this.sentence,
      required this.onChanged,
      required this.editable,
      required this.index});
  final Sentence sentence;
  final ValueChanged<Sentence> onChanged;
  final bool editable;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.pinkAccent))),
            child: Text("項番${index + 1}", style: TextStyle(fontSize: 20)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("サブタイトル", style: TextStyle(fontSize: 16)),
                AgendaEditorField(
                  editable: editable,
                  initialValue: sentence.subtitle,
                  onChanged: (str) {
                    onChanged(sentence.copyWith(subtitle: str));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Text("時間（分）", style: TextStyle(fontSize: 16)),
                ),
                Expanded(
                  child: AgendaEditorField(
                    editable: editable,
                    textAlign: TextAlign.right,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    initialValue: sentence.time.toString(),
                    onChanged: (str) {
                      onChanged(sentence.copyWith(time: int.parse(str)));
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("説明", style: TextStyle(fontSize: 16)),
                  AgendaEditorField(
                    editable: editable,
                    maxLines: null,
                    initialValue: sentence.description,
                    onChanged: (str) {
                      onChanged(sentence.copyWith(description: str));
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
