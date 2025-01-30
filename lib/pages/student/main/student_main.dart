import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu.dart';
import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu_item.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/room/room.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class StudentMain extends HookConsumerWidget {
  const StudentMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // activeRoomsProvider：今年のroomだけ呼び出すプロバイダー
    final activeRooms = ref.watch(activeRoomsProvider);

    return BasePage(
      pageTitle: "あなたの教室",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: activeRooms.when(
            data: (rooms) => StudentMainDisplay(rooms: rooms),
            // エラー時の表示
            error: (_, __) =>
            const Center(
              child: Text("読み込み失敗"),
            ),
            // 読込中の表示
            loading: () =>
            const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentMainDisplay extends ConsumerWidget {
  const StudentMainDisplay({super.key, required this.rooms});

  final List<Room> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRefNot = ref.read(currentRoomRefProvider.notifier);

    return rooms.isEmpty
        ? Center(child: Text("授業がありません"))
        : Column(
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
                  .map((room) =>
                  RadialSakuraMenuItem(
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
}