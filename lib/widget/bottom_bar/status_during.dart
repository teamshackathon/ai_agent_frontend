import 'package:code/data/firebase/during_stream.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/firebase/tools_stream.dart';
import 'package:code/data/lesson/lesson.dart';
import 'package:code/data/record/record.dart';
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
        return "${currentRoom.subject}  第${lesson.value.count}回 授業中";
      } else if (docs["state"] == "break") {
        return "${currentRoom.subject}  第${lesson.value.count}回 テスト準備中";
      } else if (docs["state"] == "test") {
        return "${currentRoom.subject}  第${lesson.value.count}回 テスト中";
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
    }, [currentRoom, currentLesson, during]);

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
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      getStatus(snap.docs[0].data()),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // if (givingLesson(
                //     snapshotData: snap.docs,
                //     teacher: teacher,
                //   ) ==
                //   "lesson")
                //   FloatingRecordButton(teacher: teacher),
                // 再生ボタン
                InkWell(
                  child: Icon(Icons.stop_circle, size: 30),
                  onTap: () async {
                    await breakLessonToDuring(
                      teacher: currentRoom.teacher,
                      currentLesson: lesson.value,
                    );
                    if (recorder.isRecording) {
                      await recorderNot.stop();
                    }
                    lesson.value = Lesson.isBlank();
                  },
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
