import 'package:code/widget/agenda/teacher_agenda_display.dart';
import 'package:flutter/material.dart';
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
