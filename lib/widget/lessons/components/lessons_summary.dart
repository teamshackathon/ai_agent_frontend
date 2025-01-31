import 'package:flutter/material.dart';
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
              Text("教室：教室A"),
              Row(children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.book)),
                    Text("教科書"),
                  ],
                )),
                Expanded(
                  child: ChatToTeacherBadgeIcon(onPressed: () {}),
                ),
                Expanded(
                  child: ChatToAIBadgeIcon(onPressed: () {}),
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
