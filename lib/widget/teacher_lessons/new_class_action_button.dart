import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../api/api.dart';
import '../../data/firebase/lesson_stream.dart';
import '../../widget/utils/sakura_progress_indicator.dart';
import '../../data/lesson/lesson.dart';
import '../../data/agenda/agenda.dart';

class NewClassActionButton extends HookConsumerWidget {
  const NewClassActionButton({super.key, required this.lastLesson});

  final Lesson lastLesson;

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
                              '新規授業アジェンダの作成',
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
                                lastLesson: lastLesson,
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
    required this.lastLesson,
  });

  final Uri uri;
  final Lesson lastLesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(currentRoomProvider);
    final pageController =
        useMemoized(() => PageController(initialPage: lastLesson.endPage));
    final current = useState<int>(lastLesson.endPage + 1);
    final start = useState<int>(0);
    final end = useState<int>(0);

    final stepper = useState<int>(0);

    return PdfDocumentViewBuilder.uri(uri, builder: (context, document) {
      if (document?.pages.isNotEmpty == true) {
        return Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: 300,
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
            max: (document?.pages.length ?? lastLesson.endPage + 1).toDouble(),
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
          Stepper(
            currentStep: stepper.value,
            onStepContinue: () {
              if (stepper.value < 2) {
                stepper.value++;
              }
            },
            onStepCancel: () {
              if (stepper.value > 0) {
                stepper.value--;
              }
            },
            steps: [
              _buildStep(
                  title: "開始ページを設定",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          start.value = current.value;
                          if (end.value == 0 || end.value < start.value) {
                            end.value = current.value;
                          }
                        },
                        child: Text("開始ページに設定"),
                      ),
                      const SizedBox(height: 8),
                      Text("開始ページ: ${start.value}"),
                    ],
                  )),
              _buildStep(
                title: "終了ページを設定",
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        end.value = current.value;
                        if (start.value == 0 || start.value > end.value) {
                          start.value = current.value;
                        }
                      },
                      child: Text("終了ページに設定"),
                    ),
                    const SizedBox(height: 8),
                    Text("終了ページ: ${end.value}"),
                  ],
                ),
              ),
              _buildStep(
                  title: "授業アジェンダの作成",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("開始ページ: ${start.value}"),
                      const SizedBox(height: 4),
                      Text("終了ページ: ${end.value}"),
                    ],
                  ))
            ],
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (details.onStepContinue != null)
                    FilledButton(
                      onPressed: details.currentStep == 2
                          ? () async {
                              if (start.value > 0 && end.value > 0) {
                                final document = await room.reference.add(
                                  Lesson(
                                    count: lastLesson.count + 1,
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
                                await createAgenda(
                                    "${room.reference.path}/${document.id}",
                                    start.value,
                                    end.value);
                                if (context.mounted) {
                                  GoRouter.of(context).pop();
                                }
                              }
                            }
                          : details.onStepContinue,
                      child: details.currentStep == 2
                          ? const Text('授業アジェンダの作成')
                          : const Text('次へ'),
                    ),
                  if (details.onStepCancel != null)
                    OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('戻る'),
                    ),
                ],
              );
            },
          )
        ]);
      } else {
        return const Center(child: SakuraProgressIndicator());
      }
    });
  }

  Step _buildStep({required String title, required Widget content}) {
    return Step(
      title: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      content: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: content,
        ),
      ),
      isActive: true,
    );
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
