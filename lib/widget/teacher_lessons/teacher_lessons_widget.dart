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
                          GoRouter.of(context).go(Routes.teacherReading);
                        },
                        icon: Icon(Icons.book)),
                    Text("教科書"),
                  ],
                )),
                Expanded(
                  child: ChatToStudentBadgeIcon(onPressed: () {
                    GoRouter.of(context).push(Routes.chatStudents);
                  }),
                ),
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
      Text("分析結果"),
    ]);
  }
}

class ChatToStudentBadgeIcon extends HookConsumerWidget {
  const ChatToStudentBadgeIcon({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // stream作成次第変更
    return Column(children: [
      Badge.count(
          count: 3,
          backgroundColor: Colors.lightBlue,
          child: IconButton(onPressed: onPressed, icon: Icon(Icons.chat))),
      Text("生徒とのチャット"),
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
    return InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ListTile(
              leading: LessonTag(
                state: lesson.state,
              ),
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

class LessonTag extends HookConsumerWidget {
  const LessonTag({super.key, required this.state});

  final String state;

  Map<String, dynamic> getState(String state) {
    switch (state) {
      case "before":
        return {
          "label": "授業前",
          "color": Colors.red,
        };
      case "lesson":
        return {
          "label": "授業中",
          "color": Colors.redAccent,
        };
      case "break":
        return {
          "label": "休憩中",
          "color": Colors.blue,
        };
      case "test":
        return {
          "label": "テスト中",
          "color": Colors.green,
        };
      case "after":
        return {
          "label": "授業後",
          "color": Colors.grey,
        };
      default:
        return {
          "label": "不明",
          "color": Colors.grey,
        };
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = getState(state);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: status["color"] ?? Colors.grey), // 枠線
        borderRadius: BorderRadius.circular(5), // 角丸
      ),
      child: Text(
        status["label"] ?? "不明",
        style: TextStyle(
          fontSize: 12, // フォントサイズ
          color: status["color"] ?? Colors.grey, // テキストの色
        ),
      ),
    );
  }
}
