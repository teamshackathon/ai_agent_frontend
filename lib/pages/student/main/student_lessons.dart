import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/store_provider.dart';
import '../../../widget/base_page/base_page.dart';

/// hotreloadの際は一度mainに帰って
class StudentLessons extends ConsumerWidget {
  const StudentLessons({super.key, required this.reference});

  final CollectionReference reference;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessonStream = ref.watch(lessonStreamProvider(reference));
    final displaySize = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "生徒コマ選択",
      body: lessonStream.when(
        data: (snapshot) {
          final lessons = snapshot.docs;
          if (lessons.isEmpty) {
            return Center(child: Text("授業がありません"));
          }
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context,index){
              final lesson = lessons[index].data();
              return InkWell(
                onTap: () async {

                },
                child: Card(
                  child: Column(
                    children: [
                      Text("第${lesson.count}回"),
                    ],
                  ),
                ),
              );
            },
          );
        },
        // エラー時の表示
        error: (_, __) => const Center(
          child: Text("読み込み失敗"),
        ),
        // 読込中の表示
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),

      // childrenを縦に並べるWidget
      // body: Column(children: [
      //   // childをいい感じの大きさに変形するWidget
      //   // Columnなどの中にListViewを入れたいときにないと怒られる
      //   if (lessons.isNotEmpty)
      //     Flexible(
      //       // ListView : Widgetを並べて配置してくれる。スクロール機能付き
      //       // builder : Widget一つ一つを宣言するわけじゃないならこの書き方
      //       child: ListView.builder(
      //         itemCount: lessons.length,
      //         itemBuilder: (context, index) => InkWell(
      //           onTap: () {
      //             GoRouter.of(context).push(Routes.studentTools);
      //           },
      //           child: Card(
      //             child: SizedBox(
      //               width: displaySize.width * 0.8,
      //               height: displaySize.width * 0.2,
      //               child: Center(child: Text(lessons[index].displayCount)),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   if (lessons.isEmpty)
      //     Expanded(
      //       child: Center(child: CircularProgressIndicator()),
      //     ),
      // ]),
    );
  }
}
