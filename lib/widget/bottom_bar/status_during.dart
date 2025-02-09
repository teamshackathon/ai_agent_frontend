import 'package:code/api/api.dart';
import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/record/record.dart';
import 'package:code/widget/floating/record_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TeacherStatusMiniBottomBar extends HookWidget {
  const TeacherStatusMiniBottomBar({
    super.key,
    required this.teacher,
    required this.dataMap,
  });

  final String teacher;
  final Map<String, dynamic> dataMap;

  String subjectToJapanese(String subject) {
    switch (subject) {
      case "math":
        return "数学";
      case "science":
        return "理科";
      case "social":
        return "社会";
      case "english":
        return "英語";
      case "japanese":
        return "国語";
      default:
        return "その他";
    }
  }

  @override
  Widget build(BuildContext context) {
    String getStatus(Map<String, dynamic> docs) {
      if (docs["state"] == "lesson") {
        return "${docs["room"]}  ${subjectToJapanese(docs["subject"])}  第${docs["count"]}回 授業中";
      } else if (docs["state"] == "break") {
        return "${docs["room"]}  ${subjectToJapanese(docs["subject"])}  第${docs["count"]}回 テスト準備中";
      } else if (docs["state"] == "test") {
        return "${docs["room"]}  ${subjectToJapanese(docs["subject"])}  第${docs["count"]}回 テスト中";
      }
      return "";
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(10),
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: dataMap["state"] == "lesson"
                        ? RecordButton(
                            teacher: teacher,
                            reference: dataMap["reference"],
                          )
                        : Icon(Icons.local_florist, color: Colors.pink[200]),
                  )),
              const SizedBox(width: 10),
              Text(
                getStatus(dataMap),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          TeacherStatusChangeButton(
            teacher: teacher,
            doc: dataMap,
          ),
        ],
      ),
    );
  }
}

class TeacherStatusChangeButton extends HookConsumerWidget {
  const TeacherStatusChangeButton({
    super.key,
    required this.teacher,
    required this.doc,
  });

  final String teacher;
  final Map<String, dynamic> doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recorder = ref.watch(streamRecorderProvider);
    final recorderNot = ref.watch(streamRecorderProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(right: 0, top: 0),
      child: doc["state"] == "lesson"
          ? IconButton(
              iconSize: 25,
              icon: Icon(Icons.stop_circle, size: 25),
              onPressed: () async {
                if (doc["state"] == "lesson") {
                  await breakLessonToDuring(
                    teacher: teacher,
                    reference: doc["reference"],
                  );
                  createQuestions(doc["reference"].path, []);
                  if (recorder.isRecording) {
                    await recorderNot.stop();
                  }
                }
              },
            )
          : SizedBox(width: 25, height: 25),
    );
  }
}
