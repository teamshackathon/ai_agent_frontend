import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LessonsSammury extends HookConsumerWidget {
  const LessonsSammury({super.key, required this.reference});

  final CollectionReference reference;

  String getSubject() {
    final String path = reference.path;
    final List<String> pathList = path.split("/");
    final subject = pathList[pathList.length - 2];
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
                "授業の概要",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("教科：${getSubject()}"),
              Text("先生：$teacher"),
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
                    child: Column(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.chat)),
                    Text("先生に聞く"),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.smart_toy)),
                    Text("AIに聞く"),
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.analytics)),
                    Text("自己分析"),
                  ],
                )),
              ])
            ]));
  }
}
