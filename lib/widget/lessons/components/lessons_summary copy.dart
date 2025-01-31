import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'lesson_badge_icon.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon),
          Text(text),
        ],
      ),
    );
  }
}

class LessonsSummary extends HookConsumerWidget {
  const LessonsSummary({super.key, required this.reference});

  final CollectionReference reference;

  String getSubject() {
    final String path = reference.path;
    final List<String> pathList = path.split("/");
    final String subject = pathList[pathList.length - 2];
    switch (subject) {
      case "math":
        return "数学";
      case "english":
        return "英語";
      case "japanese":
        return "国語";
      case "science":
        return "理科";
      case "social":
        return "社会";
      default:
        return "その他";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 先生の情報を取得
    // final teacher = ref.watch(personStatusProvider);
    final teacher = "先生の名前";

    return SizedBox(
        width: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                getSubject(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconText(icon: Icons.person_2, text: "先生：$teacher"),
              IconText(icon: Icons.meeting_room, text: "教室：教室A"),
              IconText(icon: Icons.schedule, text: "時間：火曜日 2限目"),
              Row(children: [
                Expanded(
                    child: Column(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.book)),
                    Text("教科書をみる"),
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
                )
              ]),
              Divider(),
              Container(
                height: 15,
              ),
            ]));
  }
}
