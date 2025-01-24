import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/lesson/lesson.dart';
import '../../widget/base_page/base_page.dart';

/// hotreloadの際は一度mainに帰って
class StudentLessons extends ConsumerWidget {
  const StudentLessons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lessons = ref.watch(lessonsProvider);
    final displaySize = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "生徒コマ選択",

      // childrenを縦に並べるWidget
      body: Column(children: [
        // childをいい感じの大きさに変形するWidget
        // Columnなどの中にListViewを入れたいときにないと怒られる
        if (lessons.isNotEmpty)
          Flexible(
            // ListView : Widgetを並べて配置してくれる。スクロール機能付き
            // builder : Widget一つ一つを宣言するわけじゃないならこの書き方
            child: ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) => Card(
                child: SizedBox(
                  width: displaySize.width * 0.8,
                  height: displaySize.width * 0.2,
                  child: Center(child: Text(lessons[index].displayCount)),
                ),
              ),
            ),
          ),
        if (lessons.isEmpty)
          Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
      ]),
    );
  }
}
