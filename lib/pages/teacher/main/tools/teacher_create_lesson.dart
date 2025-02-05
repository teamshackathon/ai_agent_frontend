import 'dart:ui';

import 'package:code/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../../data/agenda/agenda.dart';
import '../../../../data/firebase/lesson_stream.dart';
import '../../../../data/lesson/lesson.dart';
import '../../../../widget/base_page/base_page.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class TeacherCreateLesson extends HookConsumerWidget {
  const TeacherCreateLesson({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(currentRoomProvider);
    final storage = FirebaseStorage.instance;
    final pdf = storage.ref("text/${room.textDataName}").getDownloadURL();

    return BasePage(
      pageTitle: "新規授業作成",
      body: FutureBuilder(
        future: pdf,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: SakuraProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("読み込み失敗"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("教科書データが見つかりませんでした"));
          } else {
            // SharedPreferenceで保存できるか？
            return TeacherCreateLessonDisplay(
              uri: Uri.parse(snapshot.data ?? ""),
            );
          }
        },
      ),
    );
  }
}

class TeacherCreateLessonDisplay extends HookConsumerWidget {
  const TeacherCreateLessonDisplay({
    super.key,
    required this.uri,
  });

  final Uri uri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(currentRoomProvider);
    final lastLesson =
        ref.watch(currentLessonStreamProvider)?.data() ?? Lesson.isBlank();
    final pageController =
        useMemoized(() => PageController(initialPage: lastLesson.endPage));
    final current = useState<int>(lastLesson.endPage + 1);
    final start = useState<int>(0);
    final end = useState<int>(0);

    return PdfDocumentViewBuilder.uri(uri, builder: (context, document) {
      if (document?.pages.isNotEmpty == true) {
        return Column(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(height: 30),
            ),
            Flexible(
              flex: 19,
              child: ScrollConfiguration(
                // chrome上でスワイプを検知するために必要、実機ではいらない
                behavior: MouseDraggableScrollBehavior(),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: document?.pages.length ?? 0,
                  // ダブルタップで拡大はこのWidgetだと実装されていない、一旦諦め
                  itemBuilder: (context, index) => InteractiveViewer(
                    child: FractionallySizedBox(
                      widthFactor:
                          inRange(start.value, end.value, index) ? 0.92 : 1,
                      heightFactor:
                          inRange(start.value, end.value, index) ? 0.92 : 1,
                      child: PdfPageView(
                        document: document,
                        pageNumber: index + 1,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: inRange(start.value, end.value, index)
                              ? [
                                  BoxShadow(
                                    color: Colors.red,
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                  )
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                  onPageChanged: (page) => current.value = page + 1,
                  controller: pageController,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Slider(
                max: (document?.pages.length ?? lastLesson.endPage + 1)
                    .toDouble(),
                min: 1.0,
                value: inRange(
                        1,
                        (document?.pages.length ?? lastLesson.endPage) + 1,
                        current.value)
                    ? current.value.toDouble()
                    : 1.0,
                divisions: _calcDivisions(document?.pages.length),
                onChanged: (value) =>
                    pageController.jumpToPage((value - 1).round()),
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      start.value = current.value;
                      if (end.value == 0 || end.value < start.value) {
                        end.value = current.value;
                      }
                      infoToast(
                          log: "start : ${start.value} , end : ${end.value}");
                    },
                    child: Text("ここから"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      end.value = current.value;
                      if (start.value == 0 || start.value > end.value) {
                        start.value = current.value;
                      }
                      infoToast(
                          log: "start : ${start.value} , end : ${end.value}");
                    },
                    child: Text("ここまで"),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  room.reference.add(
                    Lesson(
                      count: lastLesson.count + 1,
                      agendaPublish: Agenda.isBlank(),
                      agendaDraft: Agenda.isBlank(),
                      questionsPublish: [],
                      questionsDraft: [],
                      reference: room.reference.doc(),
                      startPage: start.value,
                      endPage: end.value,
                    ).toMap(),
                  );
                  GoRouter.of(context).pop();
                },
                child: Text("授業作成"),
              ),
            ),
          ],
        );
      } else {
        return const Center(child: SakuraProgressIndicator());
      }
    });
  }
}

class MouseDraggableScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

int? _calcDivisions(int? count) {
  if (count == null || count < 2) return null;
  return count - 1;
}

bool inRange(int start, int end, int index) {
  return index >= start - 1 && index <= end - 1;
}
