import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
      body: activeRooms.when(
        data: (rooms) => StudentMainDisplay(rooms: rooms),
        // エラー時の表示
        error: (_, __) => const Center(
          child: Text("読み込み失敗"),
        ),
        // 読込中の表示
        loading: () => const Center(
          child: CircularProgressIndicator(),
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
        : ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return InkWell(
                onTap: () {
                  currentRefNot.state = room.reference;
                  GoRouter.of(context).push(Routes.studentLessons);
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
