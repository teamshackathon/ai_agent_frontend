import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/lesson_stream.dart';
import '../../../data/room/room.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class TeacherMain extends HookConsumerWidget {
  const TeacherMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeRooms = ref.watch(activeRoomsProvider);

    return BasePage(
      pageTitle: "教師メイン",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: activeRooms.when(
            data: (rooms) => TeacherMainDisplay(rooms: rooms),
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
      ),
    );
  }
}

class TeacherMainDisplay extends ConsumerWidget {
  const TeacherMainDisplay({super.key, required this.rooms});

  final List<Room> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoomRefNot = ref.read(currentRoomProvider.notifier);

    return rooms.isEmpty
        ? Center(child: Text("授業がありません"))
        : ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return InkWell(
                onTap: () {
                  currentRoomRefNot.state = room;
                  GoRouter.of(context).push(Routes.teacherLessons);
                },
                child: Card(
                  child: Column(
                    children: [
                      Text(room.year),
                      Text(room.roomNumber),
                      Text(room.subject),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
