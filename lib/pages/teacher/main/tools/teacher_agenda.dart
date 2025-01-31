import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/agenda/agenda.dart';
import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/lesson_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../widget/base_page/base_page.dart';

class TeacherAgenda extends ConsumerWidget {
  const TeacherAgenda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    // スマホだと戻るボタンに連動して、確認を出すことできるけど
    // Chromeだとできなさそうだから一旦諦め
    // return PopScope(
    //   canPop: false,
    //   onPopInvokedWithResult: (didPop, _) {
    //     if (didPop) return;
    //     if (editing) {
    //     } else {
    //       GoRouter.of(context).pop();
    //     }
    //   },
    return BasePage(
      pageTitle: "授業内容確認",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: TeacherAgendaDisplay(
            lesson: lesson,
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
        ),
      ),
    );
  }
}

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
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: agendaState.value.sentences.length,
            itemBuilder: (context, index) {
              return SentenceCard(
                displayWidth: displayWidth,
                displayHeight: displayHeight,
                sentence: agendaState.value.sentences[index],
                onChanged: (sentence) {
                  infoToast(log: "before : ${agendaState.value}");
                  var list = [
                    for (var i = 0; i < agendaState.value.sentences.length; i++)
                      i == index ? sentence : agendaState.value.sentences[i]
                  ];
                  agendaState.value =
                      agendaState.value.copyWith(sentences: list);
                  infoToast(log: "after : ${agendaState.value}");
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SentenceCard extends ConsumerWidget {
  const SentenceCard({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
    required this.sentence,
    required this.onChanged,
  });

  final double displayWidth, displayHeight;
  final Sentence sentence;
  final ValueChanged<Sentence> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: displayWidth * 0.9,
      height: displayHeight * 0.22,
      child: Card(
        child: Column(
          children: [
            SizedBox(
              width: displayWidth * 0.9,
              height: displayHeight * 0.1,
              child: Row(
                children: [
                  Flexible(
                    flex: 20,
                    child: AgendaEditorField(
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
              width: displayWidth * 0.9,
              height: displayHeight * 0.1,
              child: AgendaEditorField(
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

class AgendaEditorField extends HookWidget {
  const AgendaEditorField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onComplete,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
  });

  final String? initialValue;
  final ValueChanged<String>? onChanged, onComplete;
  final int? maxLines;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final text = useState<String>(initialValue ?? "");
    return TextFormField(
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      textAlign: textAlign,
      initialValue: text.value,
      onChanged: (str) {
        text.value = str;
        if (onChanged != null) {
          onChanged!(str);
        }
      },
      onEditingComplete: () {
        if (onComplete != null) {
          onComplete!(text.value);
        }
      },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        if (onComplete != null) {
          onComplete!(text.value);
        }
      },
    );
  }
}
