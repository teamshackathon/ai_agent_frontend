import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../../data/firebase/lesson_stream.dart';
import '../../../../widget/base_page/base_page.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

class TeacherCreateLesson extends HookConsumerWidget {
  const TeacherCreateLesson({super.key, this.lastPage = 1});

  final int lastPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(currentRoomProvider);
    final storage = FirebaseStorage.instance;
    final pdf = storage.ref("text/${room.textDataName}").getDownloadURL();

    return BasePage(
      pageTitle: "教科書",
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
              lastPage: lastPage,
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
    required this.lastPage,
  });

  final Uri uri;
  final int lastPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = useMemoized(() => PageController());
    final current = useState<int>(lastPage);
    final start = useState<int>(0);
    final end = useState<int>(0);

    return PdfDocumentViewBuilder.uri(uri, builder: (context, document) {
      return Column(
        children: [
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
                  child: PdfPageView(
                    document: document,
                    pageNumber: index + 1,
                    alignment: Alignment.center,
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
              max: (document?.pages.length ?? 1).toDouble(),
              min: 1.0,
              value: current.value.toDouble(),
              divisions: _calcDivisions(document?.pages.length),
              onChanged: (value) =>
                  pageController.jumpToPage((value - 1).round()),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(children: [
              ElevatedButton(
                onPressed: () {
                  start.value = current.value;
                  if(end.value == 0 || end.value )
                },
                child: Text("ここから"),
              ),
            ]),
          ),
        ],
      );
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
