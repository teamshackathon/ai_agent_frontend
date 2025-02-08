import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/person/person.dart';
import 'package:code/widget/utils/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/during_stream.dart';
import '../../../../data/firebase/tools_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../data/quiz/quiz.dart';
import '../../../../widget/quiz/answer_widget.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class StudentQuiz extends HookConsumerWidget {
  const StudentQuiz({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duringStream = ref.watch(duringStreamProvider);
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.9;
    const heightFactor = 0.95;
    final duringRef = useState<DocumentReference>(
        FirebaseFirestore.instance.collection("during").doc());
    final testNot = ref.read(testLessonProvider.notifier);

    useEffect(() {
      duringStream.whenData((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          duringRef.value = snapshot.docs[0].reference;
          final during = snapshot.docs[0].data();
          testNot.state = during["reference"];
        }
      });
      return null;
    }, [duringStream]);

    return Center(
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: duringStream.when(
          data: (snapshot) {
            final duringList = snapshot.docs;
            if (duringList.isEmpty) {
              return const Center(child: SakuraProgressIndicator());
            }
            final testLesson = ref.watch(testToolsStreamProvider);
            return testLesson.when(
              data: (snap) {
                final lesson = snap.data() ?? Lesson.isBlank();
                return StudentQuizDisplay(
                  lesson: lesson,
                  displayWidth: size.width * widthFactor,
                  displayHeight: size.height * heightFactor,
                  duringRef: duringRef.value,
                );
              },
              error: (_, __) => const Center(child: Text("読み込み失敗")),
              loading: () => const Center(child: SakuraProgressIndicator()),
            );
          },
          error: (_, __) => const Center(child: Text("読み込み失敗")),
          loading: () => const Center(child: SakuraProgressIndicator()),
        ),
      ),
    );
  }
}

class StudentQuizDisplay extends HookConsumerWidget {
  const StudentQuizDisplay({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
    required this.lesson,
    required this.duringRef,
  });

  final double displayWidth, displayHeight;
  final Lesson lesson;
  final DocumentReference duringRef;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reference = lesson.reference;
    final quizzes = useState<List<Quiz>>(lesson.questionsPublish);
    final loading = useState<bool>(false);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "小テスト",
            style: TextStyle(fontSize: 25),
          ),
        ),
        Flexible(
          child: ListView.separated(
            itemCount: quizzes.value.length,
            itemBuilder: (context, index) => AnswerWidget(
              count: index + 1,
              quiz: quizzes.value[index],
              onChanged: (str) {
                quizzes.value = [
                  for (final quiz in quizzes.value)
                    quizzes.value[index].title == quiz.title
                        ? quiz.copyWith(answer: str)
                        : quiz
                ];
              },
            ),
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
          ),
        ),
        SizedBox(height: 20),
        LoadingButton(
          text: "テスト提出",
          onPressed: () async {
            loading.value = true;
            final student = await ref.watch(personStatusProvider.future);
            final list = [for (final quiz in quizzes.value) quiz.answerToMap()];
            await reference
                .collection("students")
                .doc(student.folderName)
                .set({"answers": list, "name": student.folderName});
            await duringRef.update({
              "finish": FieldValue.arrayUnion([student.folderName])
            });
            loading.value = false;
          },
          isLoading: loading.value,
          width: 150,
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
