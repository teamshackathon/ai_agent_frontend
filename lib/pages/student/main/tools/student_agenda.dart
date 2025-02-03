import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/agenda/agenda.dart';
import '../../../../data/firebase/lesson_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../widget/base_page/base_page.dart';

class StudentAgenda extends ConsumerWidget {
  const StudentAgenda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonStreamProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "授業内容確認",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: StudentAgendaDisplay(
            lesson: lesson,
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
        ),
      ),
    );
  }
}

class StudentAgendaDisplay extends HookConsumerWidget {
  const StudentAgendaDisplay({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
    required this.lesson,
  });

  final double displayWidth, displayHeight;
  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agenda = lesson.agendaPublish;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: displayHeight * 0.03),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text("タイトル"),
        ),
        SizedBox(
          width: displayWidth * 0.95,
          height: displayHeight * 0.1,
          child: Text(agenda.title),
        ),
        Expanded(
          child: agenda.sentences.isEmpty
              ? Text("まだ公開されていません")
              : ListView.builder(
                  itemCount: agenda.sentences.length,
                  itemBuilder: (context, index) {
                    return SentenceCard(
                      displayWidth: displayWidth,
                      displayHeight: displayHeight,
                      sentence: agenda.sentences[index],
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
  });

  final double displayWidth, displayHeight;
  final Sentence sentence;

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
                    child: Text(sentence.subtitle),
                  ),
                  Spacer(flex: 20),
                  Flexible(
                    flex: 5,
                    child: Text("${sentence.time}分"),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: displayWidth * 0.9,
              height: displayHeight * 0.1,
              child: Text(sentence.description, maxLines: null),
            ),
          ],
        ),
      ),
    );
  }
}
