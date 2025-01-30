
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
    final currentRefNot = ref.read(currentRoomRefProvider.notifier);

    return BasePage(
      pageTitle: "あなたの教室",
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
