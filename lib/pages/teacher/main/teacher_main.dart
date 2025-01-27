import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/room/room.dart';
import '../../data/person/person.dart';
import '../../widget/base_page/base_page.dart';

class TeacherMain extends ConsumerWidget {
  const TeacherMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(personStatusProvider);
    final rooms = ref.watch(roomsProvider);
    final displaySize = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "教師メイン",

      // childrenを縦に並べるWidget
      body: Column(children: [
        // status閲覧用
        SizedBox(
          width: displaySize.width * 0.8,
          height: displaySize.width * 0.1,
          child: Text(status.toString()),
        ),

        // childをいい感じの大きさに変形するWidget
        // Columnなどの中にListViewを入れたいときにないと怒られる
        Flexible(
          // ListView : Widgetを並べて配置してくれる。スクロール機能付き
          // builder : Widget一つ一つを宣言するわけじゃないならこの書き方
          child: ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) => Card(
              child: SizedBox(
                width: displaySize.width * 0.8,
                height: displaySize.width * 0.2,
                child: Text(rooms[index].name),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
