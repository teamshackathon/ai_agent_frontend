import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/firebase/tools_stream.dart';
import 'package:code/data/lesson/lesson.dart';
import 'package:code/data/record/record.dart';
import 'package:code/widget/floating/record_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

class TeacherStatusMiniBottomBar extends HookConsumerWidget {
  const TeacherStatusMiniBottomBar({
    super.key,
    required this.teacher,
  });

  final String teacher;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoom = ref.watch(currentRoomProvider);
    final currentLesson = ref.watch(currentLessonProvider);
    final recorder = ref.watch(streamRecorderProvider);
    final recorderNot = ref.read(streamRecorderProvider.notifier);

    final during = ref.watch(duringStreamProvider);

    final lesson = useState<Lesson>(currentLesson);

    Logger().i("currentRoom: $currentRoom");
    Logger().i("currentlesson: $currentLesson");
    Logger().i("lesson: $lesson");

    String getStatus(Map<String, dynamic> docs) {
      if (docs["state"] == "lesson") {
        return "${subjectToJapanese(currentRoom.subject)}  第${lesson.value.count}回 授業中";
      } else if (docs["state"] == "break") {
        return "${subjectToJapanese(currentRoom.subject)}  第${lesson.value.count}回 テスト準備中";
      } else if (docs["state"] == "test") {
        return "${subjectToJapanese(currentRoom.subject)}  第${lesson.value.count}回 テスト中";
      }
      return "";
    }

    useEffect(() {
      during.when(
          data: (snap) {
            if (duringLesson(
                  snapshotData: snap.docs,
                  roomNumber: currentRoom.roomNumber,
                  subject: currentRoom.subject,
                  count: currentLesson.count,
                ) ==
                true) {
              lesson.value = currentLesson;
            }
          },
          error: (_, __) {},
          loading: () {});
      return null;
    }, [currentRoom, currentlesson, during]);


    return during.when(
      data: (snap) {
        if (duringLessonNotCount(
          snapshotData: snap.docs,
          roomNumber: currentRoom.roomNumber,
          subject: currentRoom.subject,
        )) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(10),
            width: 350,
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
                          child: snap.docs[0]["state"] == "lesson"
                              ? RecordButton(teacher: teacher)
                              : Icon(Icons.local_florist,
                                  color: Colors.pink[200]),
                        )),
                    const SizedBox(width: 10),
                    Text(
                      getStatus(snap.docs[0].data()),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TeacherStatusChangeButton(
                  teacher: teacher,
                  doc: snap.docs[0],
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
      error: (_, __) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
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
  final QueryDocumentSnapshot<Map<String, dynamic>> doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoom = ref.watch(currentRoomProvider);
    final currentlesson = ref.watch(currentLessonProvider);
    final recorder = ref.watch(streamRecorderProvider);
    final recorderNot = ref.watch(streamRecorderProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(right: 0, top: 0),
      child: IconButton(
        iconSize: 25,
        icon: Icon(Icons.stop_circle, size: 25),
        onPressed: () async {
          Logger()
              .i("Change status to ${doc["state"]}, ${currentlesson.count}");
          if (doc["state"] == "lesson" && currentlesson.count != 0) {
            await breakLessonToDuring(
              teacher: currentRoom.teacher,
              currentLesson: currentlesson,
            );
            if (recorder.isRecording) {
              await recorderNot.stop();
            }
          } else if (doc["state"] == "break" && currentlesson.count != 0) {
            await startTestToDuring(
                teacher: teacher, currentLesson: currentlesson);
          } else if (doc["state"] == "test" && currentlesson.count != 0) {
            await finishLessonToDuring(
                teacher: teacher, currentLesson: currentlesson);
          }
        },
      ),
    );
  }
}
