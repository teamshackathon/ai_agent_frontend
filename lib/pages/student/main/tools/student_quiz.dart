import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/tools_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../data/quiz/quiz.dart';
import '../../../../widget/base_page/base_page.dart';
import '../../../../widget/quiz/answer_widget.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class StudentQuiz extends ConsumerWidget {
  const StudentQuiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(toolsStreamProvider);
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
          child: lessonStream.when(
            data: (lesson) {
              return StudentQuizDisplay(
                lesson: lesson.data() ?? Lesson.isBlank(),
                displayWidth: size.width * widthFactor,
                displayHeight: size.height * widthFactor,
              );
            }, // エラー時の表示
            error: (_, __) => const Center(
              child: Text("読み込み失敗"),
            ),
            // 読込中の表示
            loading: () => const Center(
              child: SakuraProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentQuizDisplay extends HookConsumerWidget {
  const StudentQuizDisplay(
      {super.key,
      required this.displayWidth,
      required this.displayHeight,
      required this.lesson});

  final double displayWidth, displayHeight;
  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final quizzes = useState<List<Quiz>>(lesson.questionsPublish);

    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: quizzes.value.length,
            itemBuilder: (context, index) => AnswerWidget(
              quiz: quizzes.value[index],
              onChanged: (str) {
                final list = [
                  for (var i = 0; i < quizzes.value.length; i++)
                    i == index
                        ? quizzes.value[i].copyWith(answer: str)
                        : quizzes.value[i],
                ];
                quizzes.value = list;
              },
            ),
          ),
        ),
      ],
    );
  }
}
