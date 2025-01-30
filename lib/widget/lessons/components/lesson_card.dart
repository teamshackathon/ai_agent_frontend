import 'package:code/data/lesson/lesson.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LessonCard extends HookConsumerWidget {
  const LessonCard({super.key, required this.lesson, required this.onTap});

  final Lesson lesson;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Text("第${lesson.count}の授業"),
              Text("実施日："),
              Container(
                height: 15,
              ),
              Flex(direction: Axis.horizontal, children: [
                LessonDocumentTag(label: "授業資料"),
                LessonDocumentTag(label: "テスト"),
                LessonDocumentTag(label: "宿題"),
                LessonDocumentTag(label: "補足資料"),
              ]),
              Container(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LessonDocumentTag extends HookConsumerWidget {
  const LessonDocumentTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.blue, // 背景色
                shape: BoxShape.circle, // 円形の縁
              ),
              child: Icon(
                Icons.book,
                color: Colors.white,
                size: 13.0, // アイコンのサイズ
              ),
            ),
            SizedBox(width: 4.0), // アイコンとテキストの間にスペースを追加
            Text(
              label,
              style: TextStyle(
                color: Colors.blue, // テキストの色
              ),
            ),
          ],
        ));
  }
}
