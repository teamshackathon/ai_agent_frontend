import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/room/room.dart';
import '../../route/route.dart';

class ShortcutButton extends HookConsumerWidget {
  const ShortcutButton(
      {super.key, required this.shortcut, required this.rooms});

  final QueryDocumentSnapshot<Map<String, dynamic>> shortcut;
  final List<Room> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = shortcut.data();
    final currentRoomNot = ref.read(currentRoomProvider.notifier);
    final currentLessonNot = ref.read(currentLessonStreamProvider.notifier);
    final lessonStream = ref.watch(lessonsStreamProvider.future);

    return FloatingActionButton(
      onPressed: () async {
        // ショートカットで飛ばされる道中で入力されるべきデータをここで入力する
        currentRoomNot.state = searchRoom(rooms, data["subject"]);
        await lessonStream.then((lessons) {
          final wannaGo = lessons.docs.firstWhere((lesson) {
            return lesson.data().count == data["count"];
          });
          currentLessonNot.state = wannaGo;
          if (context.mounted) {
            GoRouter.of(context).push(Routes.studentTools);
          }
        }, onError: (e) => infoToast(log: "error : $e"));
      },
      child: Column(children: [
        Text("現在の授業"),
        Text(data.toString()),
      ]),
    );
  }
}
