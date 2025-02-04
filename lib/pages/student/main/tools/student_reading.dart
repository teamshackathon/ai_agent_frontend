import 'dart:math' as math;

import 'package:code/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

import '../../../../data/firebase/lesson_stream.dart';
import '../../../../widget/base_page/base_page.dart';
import '../../../../widget/utils/sakura_progress_indicator.dart';

final pdfCtrlProvider =
    StateProvider<PdfViewerController>((ref) => PdfViewerController());

class StudentReading extends HookConsumerWidget {
  const StudentReading({super.key});

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
            return StudentReadingDisplay(uri: Uri.parse(snapshot.data ?? ""));
          }
        },
      ),
    );
  }
}

// スワイプ方向を指定できてもいいかもね
class StudentReadingDisplay extends HookConsumerWidget {
  const StudentReadingDisplay({super.key, required this.uri});

  final Uri uri;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ctrl = ref.watch(pdfCtrlProvider);
    var ready = ctrl.isReady;
    infoToast(log: ready);

    useEffect(() {
      ready = ctrl.isReady;
      return null;
    }, [ctrl]);

    return !ctrl.isReady
        ? const Center(child: SakuraProgressIndicator())
        : Column(
            children: [
              Slider(
                value: (ctrl.pageNumber ?? 0) / ctrl.pageCount,
                onChanged: (value) {
                  ctrl.setCurrentPageNumber((value * ctrl.pageCount).toInt());
                },
              ),
              Expanded(
                child: PdfViewer.uri(
                  uri,
                  params: PdfViewerParams(
                    loadingBannerBuilder: (context, _, __) =>
                        const Center(child: SakuraProgressIndicator()),
                    layoutPages: (pages, params) {
                      final height = pages.fold(0.0,
                              (prev, page) => math.max(prev, page.height)) +
                          params.margin * 2;
                      final pageLayouts = <Rect>[];
                      double x = params.margin;
                      for (var page in pages) {
                        pageLayouts.add(
                          Rect.fromLTWH(
                            x,
                            (height - page.height) / 2, // center vertically
                            page.width,
                            page.height,
                          ),
                        );
                        x += page.width + params.margin;
                      }
                      return PdfPageLayout(
                        pageLayouts: pageLayouts,
                        documentSize: Size(x, height),
                      );
                    },
                  ),
                  controller: ctrl,
                ),
              ),
            ],
          );
    // return Column(
    //   children: [
    //     Expanded(
    //       child: PdfDocumentViewBuilder.uri(
    //         uri,
    //         builder: (context, document) => PageView.builder(
    //           itemCount: document?.pages.length ?? 0,
    //           itemBuilder: (context, index) {
    //             return PdfPageView(
    //               document: document,
    //               pageNumber: index + 1,
    //               alignment: Alignment.center,
    //             );
    //           },
    //           controller: page,
    //         ),
    //       ),
    //     ),
    //     Slider(
    //       value: page.page ?? 0,
    //       onChanged: (value) {
    //         page.jumpTo(value);
    //       },
    //     ),
    //   ],
    // );
  }
}
