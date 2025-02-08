import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firebase/tools_stream.dart';
import '../../data/room/room.dart';
import '../../route/route.dart';

String displaySubject(String subject) {
  switch (subject) {
    case "english":
      return "英語";
    case "japanese":
      return "国語";
    case "math":
      return "数学";
    case "science":
      return "理科";
    case "social":
      return "社会";
    default:
      return "不明";
  }
}

String displayState(String state) {
  switch (state) {
    case "lesson":
      return "授業中";
    case "break":
      return "テスト前";
    case "test":
      return "テスト中";
    default:
      return "なぞのばしょ";
  }
}

class ShortcutButton extends HookConsumerWidget {
  const ShortcutButton({
    super.key,
    required this.shortcut,
    required this.rooms,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>> shortcut;
  final List<Room> rooms;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = shortcut.data();
    final currentRoomNot = ref.read(currentRoomProvider.notifier);
    final currentLessonNot = ref.read(currentLessonProvider.notifier);

    return FloatingActionButton(
      onPressed: () async {
        // ショートカットで飛ばされる道中で入力されるべきデータをここで入力する
        currentRoomNot.state = await searchRoom(rooms, data["subject"]);
        final lessonStream = ref.watch(lessonsStreamProvider.future);
        await lessonStream.then((lessons) {
          final wannaGo = lessons.docs.firstWhere((lesson) {
            return lesson.data().count == data["count"];
          });
          currentLessonNot.state = wannaGo.data();
          if (context.mounted) {
            GoRouter.of(context).push(Routes.studentTools);
          }
        }, onError: (e) => infoToast(log: "error : $e"));
      },
      backgroundColor: Color(0xFFFFEEF5),
      child: ShortcutButtonDesign(data: data),
    );
  }
}

class ShortcutButtonDesign extends StatelessWidget {
  const ShortcutButtonDesign({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          "${displayState(data["state"])} : ${displaySubject(data["subject"])}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
