import 'package:code/firebase/firestore/chat/create_chat_room.dart';
import 'package:code/route/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/room/room.dart';
import 'lesson_badge_icon.dart';

class LessonsSummary extends HookConsumerWidget {
  const LessonsSummary({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                "授業の概要",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("教科：${room.displaySubject}"),
              Text("先生：${room.teacher}"),
              Text("教室：${room.classrooms}"),
              Text("時間割：${room.dateOfLessons}"),
              Text("授業時間：${room.teachingHours}分"),
              Row(children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          GoRouter.of(context).push(Routes.studentReading);
                        },
                        icon: Icon(Icons.book)),
                    Text("教科書"),
                  ],
                )),
                Expanded(
                  child: ChatToTeacherBadgeIcon(onPressed: () {
                    createChatRoom(ref: ref, target: "teacher");
                    GoRouter.of(context).push(Routes.chatTeacher);
                  }),
                ),
                Expanded(
                  child: ChatToAIBadgeIcon(onPressed: () {
                    createChatRoom(ref: ref, target: "ai");
                    GoRouter.of(context).push(Routes.chatAI);
                  }),
                ),
                Expanded(
                  child: AnalyticsBadgeIcon(onPressed: () {}),
                ),
              ]),
              Divider(),
              Container(
                height: 15,
              ),
            ]));
  }
}
