import 'package:code/toast.dart';
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
    final currentRefNot = ref.read(currentRoomRefProvider.notifier);

    return BasePage(
      pageTitle: "教師メイン",
      body: activeRooms.when(
        data: (rooms) {
          if (rooms.isEmpty) {
            return Center(child: Text("クラスがありません"));
          }
          return Center(
            child: FractionallySizedBox(
              widthFactor: 0.95,
              heightFactor: 0.95,
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return InkWell(
                    onTap: () {
                      currentRefNot.state = room.reference;
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
              ),
            ),
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
    );
  }
}
