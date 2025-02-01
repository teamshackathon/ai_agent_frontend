import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/lesson_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../data/quiz/quiz.dart';
import '../../../../toast.dart';
import '../../../../widget/base_page/base_page.dart';
import '../../../../widget/quiz/quiz_edit_widget.dart';

class TeacherQuiz extends ConsumerWidget {
  const TeacherQuiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(currentLessonProvider);
    final lesson = snapshot?.data() ?? Lesson.isBlank();
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "小テスト確認",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: TeacherQuizDisplay(
            lesson: lesson,
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
        ),
      ),
    );
  }
}

class TeacherQuizDisplay extends HookConsumerWidget {
  const TeacherQuizDisplay(
      {super.key,
      required this.displayWidth,
      required this.displayHeight,
      required this.lesson});

  final double displayWidth, displayHeight;
  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final quizzes = useState<List<Quiz>>(lesson.questionsDraft);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            infoToast(log: quizzes.value.toString());
            await reference.update({
              "questions_draft": [for (var q in quizzes.value) q.toMap()]
            });
          },
          child: Text("下書き保存"),
        ),
        ElevatedButton(
          onPressed: () async {
            infoToast(log: quizzes.value.toString());
            await reference.update({
              "questions_draft": [for (var q in quizzes.value) q.toMap()]
            });
            await reference.update({
              "questions_publish": [for (var q in quizzes.value) q.toMap()]
            });
          },
          child: Text("公開"),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: quizzes.value.length,
            itemBuilder: (context, index) => QuizEditWidget(
              quiz: quizzes.value[index],
              onChanged: (quiz) {
                infoToast(log: "before : ${quizzes.value}");
                var list = [
                  for (var i = 0; i < quizzes.value.length; i++)
                    i == index ? quiz : quizzes.value[i]
                ];
                quizzes.value = list;
                infoToast(log: "after : ${quizzes.value}");
              },
              editable: true,
            ),
          ),
        ),
      ],
    );
  }
}
