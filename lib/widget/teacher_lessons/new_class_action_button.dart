import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/api/api.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../widget/utils/sakura_progress_indicator.dart';
import '../../data/lesson/lesson.dart';
import '../../data/agenda/agenda.dart';

class NewClassActionButton extends HookConsumerWidget {
  const NewClassActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(currentRoomProvider);
    final storage = FirebaseStorage.instance;
    Logger().i("text/${room.textDataName}");
    final pdf = storage.ref("text/${room.textDataName}").getDownloadURL();

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
              initialChildSize: 1.0,
              minChildSize: 0.5,
              maxChildSize: 1.0,
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
                              '新規授業の作成',
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
                        FutureBuilder(
                          future: pdf,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: SakuraProgressIndicator());
                            } else if (snapshot.hasError) {
                              Logger().e(snapshot.data);
                              return const Center(child: Text("読み込み失敗"));
                            } else if (!snapshot.hasData) {
                              Logger().e(snapshot.data);
                              return const Center(
                                  child: Text("教科書データが見つかりませんでした"));
                            } else {
                              // SharedPreferenceで保存できるか？
                              return TeacherCreateLessonDisplay(
                                uri: Uri.parse(snapshot.data ?? ""),
                              );
                            }
                          },
                        ),
                        // 他のウィジェットをここに追加
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
          Icon(Icons.create),
          Text("作成"),
        ],
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 400,
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: document?.pages.length ?? 0,
                itemBuilder: (context, index) => PdfPageView(
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
                onPageChanged: (page) => current.value = page + 1,
                controller: pageController,
              ),
            ),
            Slider(
              max:
                  (document?.pages.length ?? lastLesson.endPage + 1).toDouble(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    start.value = current.value;
                    if (end.value == 0 || end.value < start.value) {
                      end.value = current.value;
                    }
                  },
                  child: Text("ここから"),
                ),
                ElevatedButton(
                  onPressed: () {
                    end.value = current.value;
                    if (start.value == 0 || start.value > end.value) {
                      start.value = current.value;
                    }
                  },
                  child: Text("ここまで"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (start.value > 0 && end.value > 0) {
                  final lessonsStream = ref.watch(lessonsStreamProvider);
                  final List<QuerySnapshot<Lesson>> lessons = [];
                  lessonsStream.when(
                      data: (snapshot) => lessons.add(snapshot),
                      error: (_, __) => [],
                      loading: () => []);
                  Logger().i(lessons[0].docs.length);

                  final document = await room.reference.add(
                    Lesson(
                      count: lessons[0].docs.length + 1,
                      agendaPublish: Agenda.isBlank(),
                      agendaDraft: Agenda.isBlank(),
                      questionsPublish: [],
                      questionsDraft: [],
                      reference: room.reference.doc(),
                      startPage: start.value,
                      endPage: end.value,
                      state: "before",
                    ).toMap(),
                  );
                  createAgenda("${room.reference.path}/${document.id}",
                      start.value, end.value);
                  GoRouter.of(context).pop();
                }
              },
              child: Text("授業作成"),
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
