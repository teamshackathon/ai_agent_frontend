import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/firebase/firestore/chat/create_chat_room.dart';
import 'package:code/route/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/room/room.dart';
import '../lessons/components/lesson_badge_icon.dart';
import '../../data/lesson/lesson.dart';

class TeacherLessonsSummary extends HookConsumerWidget {
  const TeacherLessonsSummary({super.key, required this.room});

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
              Text("教室：${room.classrooms}"),
              Text("時間割：${room.dateOfLessons}"),
              Text("授業時間：${room.teachingHours}分"),
              Row(children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          GoRouter.of(context).push(Routes.teacherReading);
                        },
                        icon: Icon(Icons.book)),
                    Text("教科書"),
                  ],
                )),
                Expanded(
                  child: ChatToAIBadgeIcon(onPressed: () {
                    createChatRoom(ref: ref, target: "ai");
                    GoRouter.of(context).push(Routes.chatAIAsTeacher);
                  }),
                ),
                Expanded(
                  child: AllAnalyticsBadgeIcon(onPressed: () {}),
                ),
              ]),
              Divider(),
              Container(
                height: 15,
              ),
            ]));
  }
}

class AllAnalyticsBadgeIcon extends HookConsumerWidget {
  const AllAnalyticsBadgeIcon({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // stream作成次第変更
    return Column(children: [
      Badge(
          label: Text("new"),
          backgroundColor: Colors.blue,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.analytics))),
      Text("生徒の分析結果"),
    ]);
  }
}

class TeacherLessonsCard extends HookConsumerWidget {
  const TeacherLessonsCard(
      {super.key, required this.lesson, required this.onTap});

  final Lesson lesson;
  final VoidCallback onTap;

  String getTitle(Lesson lesson) {
    if (lesson.agendaPublish.title == "") {
      if (lesson.agendaDraft.title == "") {
        return "タイトルなし";
      } else {
        return lesson.agendaDraft.title;
      }
    } else {
      return lesson.agendaPublish.title;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final during = ref.watch(duringStreamProvider);
    final currentRoom = ref.watch(currentRoomProvider);

    // 授業中かどうか
    final status = during.when(
        data: (snapshot) {
          switch (duringLesson(
            snapshotData: snapshot.docs,
            roomNumber: currentRoom.roomNumber,
            subject: currentRoom.subject,
            count: lesson.count,
          )) {
            case true:
              return true;
            case false:
              return false;
            default:
              return false;
          }
        },
        // エラー時の表示
        error: (_, __) => false,
        // 読込中の表示
        loading: () => false);

    return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ListTile(
              leading:
                  lesson.agendaPublish.title == "" ? Text("下書き") : Text("公開済"),
              title: Row(
                children: [
                  Text(
                    "第${lesson.count.toString()}回",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 20,
                  ),
                  status
                      ? LessonDocumentTag(
                          label: "授業中",
                          color: Colors.redAccent,
                        )
                      : Text(""),
                  Container(
                    width: 20,
                  ),
                  LessonDocumentTag(
                    label: "テスト作成前",
                    color: Colors.red,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTitle(lesson),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(),
          ],
        ));
  }
}

class LessonDocumentTag extends HookConsumerWidget {
  const LessonDocumentTag(
      {super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(right: 0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: color), // 枠線
                borderRadius: BorderRadius.circular(5), // 角丸
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: color, // テキストの色
                ),
              ),
            ),
          ],
        ));
  }
}
