import 'package:code/data/firebase/during_stream.dart';
import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu.dart';
import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu_item.dart';
import 'package:code/widget/shortcut/shortcut.dart';
import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

    final size = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "あなたの教室",
      body: Stack(
        children: [
          Positioned(
            bottom: -size.height * 0.3,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/hand.svg',
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.95,
              heightFactor: 0.95,
              child: activeRooms.when(
                data: (rooms) => StudentMainDisplay(rooms: rooms),
                // エラー時の表示
                error: (_, __) => const Center(
                  child: Text("読み込み失敗"),
                ),
                // 読込中の表示
                loading: () => const Center(
                  child: SakuraProgressIndicator(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StudentMainDisplay extends ConsumerWidget {
  const StudentMainDisplay({super.key, required this.rooms});

  final List<Room> rooms;

  String getClass(String room) {
    return room.split("-")[1];
  }

  String getGrade(String room) {
    return room.split("-")[0];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoomNot = ref.read(currentRoomProvider.notifier);
    final during = ref.watch(duringStreamProvider);

    return rooms.isEmpty
        ? Center(child: Text("授業がありません"))
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text(
                  "${rooms[0].year}年度 ${getGrade(rooms[0].roomNumber)}年${getClass(rooms[0].roomNumber)}組",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 30),
                child: Text(
                  "授業を選んでください",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              during.when(
                data: (snapshots) {
                  if (snapshots.docs.isEmpty) return Spacer();
                  return SizedBox(
                    width: 300,
                    height: 100,
                    child: ShortcutButton(
                      rooms: rooms,
                      shortcut: snapshots.docs.first,
                    ),
                  );
                },
                error: (_, __) => Spacer(),
                loading: () => Spacer(),
              ),
              RadialSakuraMenu(
                items: rooms
                    .map(
                      (room) => RadialSakuraMenuItem(
                        key: UniqueKey(),
                        subject: getOptionFromIndex(room.subject),
                        angle: 2 * math.pi / rooms.length * rooms.indexOf(room),
                        onTap: () {
                          currentRoomNot.state = room;
                          GoRouter.of(context).push(Routes.studentLessons);
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          );
  }
}
