import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/toast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/room/room.dart';
import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

class StudentMain extends HookConsumerWidget {
  const StudentMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // activeRoomsProvider：今年のroomだけ呼び出すプロバイダー
    final rooms = ref.watch(activeRoomsProvider.future);
    final currentRefNot = ref.read(currentRoomRefProvider.notifier);

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
            // 読み込み完了
            return Center(
              child: FractionallySizedBox(
                widthFactor: 0.95,
                heightFactor: 0.95,
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final room = snapshot.data?[index];
                    return InkWell(
                      onTap: () {
                        currentRefNot.state = room.reference;
                        infoToast(log: room.reference.toString());
                        GoRouter.of(context).push(Routes.studentLessons);
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Text(room!.year),
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
          }
        },
      ),
    );
  }
}
