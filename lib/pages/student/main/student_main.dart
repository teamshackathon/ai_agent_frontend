import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu.dart';
import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu_item.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../../../data/room/room.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class StudentMain extends HookConsumerWidget {
  const StudentMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // activeRoomsProvider：今年のroomだけ呼び出すプロバイダー
    final rooms = ref.watch(activeRoomsProvider.future);

    return BasePage(
      pageTitle: "あなたの教室",
      body: FutureBuilder(
        future: rooms,
        // snapshot : 現在の状況だと思って差し支えない
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 読込中
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 読込中のエラー
            return Center(child: Text("読み込みエラー"));
          } else if (snapshot.data!.isEmpty) {
            // firestore側にデータがない場合はこうなるはず
            return Center(child: Text("受けてる授業なし"));
          } else {
            final rooms = snapshot.data ?? [];

            return Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "${rooms[0].year}年度 ${rooms[0].roomNumber}",
                      style: TextStyle(fontSize: 20),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Text(
                      "授業を選んでください",
                      style: TextStyle(fontSize: 15),
                    )),
                Spacer(),
                Expanded(
                  child: RadialSakuraMenu(
                      items: rooms
                          .map((room) => RadialSakuraMenuItem(
                                key: UniqueKey(),
                                subject: getOptionFromIndex(room.subject),
                                angle: 2 *
                                    math.pi /
                                    rooms.length *
                                    rooms.indexOf(room),
                                onTap: () {
                                  GoRouter.of(context).push(
                                    Routes.studentLessons,
                                    extra: room.reference,
                                  );
                                },
                              ))
                          .toList()),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
