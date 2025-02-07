import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../data/lesson/lesson.dart';
import '../../data/agenda/agenda.dart';
import '../../widget/agenda_materials/agenda_editor_field.dart';
import '../../widget/agenda_materials/sentence_card.dart';
import '../../data/firebase/tools_stream.dart';
import '../utils/sakura_progress_indicator.dart';
import 'edit_agenda_action_button.dart';
import 'teacher_agenda_sentence_card.dart';

class _TeacherAgendaTabBarView extends HookConsumerWidget {
  const _TeacherAgendaTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(toolsStreamProvider);

    return lessonStream.when(
      data: (snapshot) => Scaffold(
        // 透明
        backgroundColor: Colors.transparent,
        body: _TeacherAgendaDisplay(
          lesson: snapshot.data() ?? Lesson.isBlank(),
        ),
        floatingActionButton: EditAgendaActionButton(
          lesson: snapshot.data() ?? Lesson.isBlank(),
        ),
      ),
      // エラー時の表示
      error: (_, __) => const Center(child: Text("読み込み失敗")),
      // 読込中の表示
      loading: () => const Center(child: SakuraProgressIndicator()),
    );
  }
}

class _EditAgendaActionButton extends HookConsumerWidget {
  const _EditAgendaActionButton({super.key, required this.lesson});

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

class _TeacherAgendaDisplay extends HookConsumerWidget {
  const _TeacherAgendaDisplay({
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

class _TeacherAgendaSentenceCard extends ConsumerWidget {
  const _TeacherAgendaSentenceCard({
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
