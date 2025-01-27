import 'package:code/firebase/firestore/get_data/get_lessons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../data/teacher/teacher.dart';
import '../../../firebase/firestore/get_data/get_rooms.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/room/room.dart';
import '../../../data/person/person.dart';
import '../../../firebase/firestore/get_data/get_teachers.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class StudentMain extends HookConsumerWidget {
  const StudentMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(roomsProvider);
    final displaySize = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "生徒メイン",

      // childrenを縦に並べるWidget
      body: Column(children: [
        // status閲覧用
        ElevatedButton(
          onPressed: () async {
            await getTeachers(ref: ref);
            await getRooms(ref: ref);
          },
          child: Text("get"),
        ),

        // childをいい感じの大きさに変形するWidget
        // Columnなどの中にListViewを入れたいときにないと怒られる
        if (rooms.isNotEmpty)
          Flexible(
            // ListView : Widgetを並べて配置してくれる。スクロール機能付き
            // builder : Widget一つ一つを宣言するわけじゃないならこの書き方
            child: ListView.builder(
              itemCount: rooms.length,
              // InkWellでカードをタップ可能にする(GestureDetectorより見た目が良かった気がする)
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  getLessons(
                    ref: ref,
                    year: rooms[index].year,
                    room: rooms[index].roomNumber,
                    subject: rooms[index].id,
                  );
                  GoRouter.of(context).push(Routes.studentLessons);
                },
                child: Card(
                  child: SizedBox(
                    width: displaySize.width * 0.8,
                    height: displaySize.width * 0.2,
                    child: Center(
                      child: Column(
                        children: [
                          Text(rooms[index].name),
                          Text(rooms[index].teacher),
                          Text(rooms[index].year),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        if (rooms.isEmpty)
          Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
      ]),
    );
  }
}
