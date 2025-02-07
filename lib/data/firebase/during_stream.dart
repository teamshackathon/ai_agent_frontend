import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../lesson/lesson.dart';
import '../person/person.dart';

final duringStreamProvider = StreamProvider((ref) async* {
  final user = await ref.watch(personStatusProvider.future);
  final reference = FirebaseFirestore.instance.collection("during");
  if (user is Student) {
    yield* reference
        .where("room", isEqualTo: user.rooms[0]["room"])
        .snapshots();
  }
  yield* reference.snapshots();
});

// firestoreのduringに現在の授業情報を書き込み
Future<void> addLessonToDuring({
  required String roomNumber,
  required String subject,
  required int count,
  required String teacher,
  required Lesson currentLesson,
}) async {
  await FirebaseFirestore.instance.collection("during").doc(teacher).set({
    "room": roomNumber,
    "subject": subject,
    "count": count,
    "teacher": teacher,
    "state": "lesson",
  });
  await currentLesson.reference.update({"state": "lesson"});
}

Future<void> cancelLessonToDuring(
    {required String teacher, required Lesson currentLesson}) async {
  await FirebaseFirestore.instance.collection("during").doc(teacher).delete();
  await currentLesson.reference.update({"state": "before"});
}

Future<void> breakLessonToDuring(
    {required String teacher, required Lesson currentLesson}) async {
  await FirebaseFirestore.instance
      .collection("during")
      .doc(teacher)
      .update({"state": "break"});
  await currentLesson.reference.update({"state": "break"});
}

Future<void> startTestToDuring(
    {required String teacher, required Lesson currentLesson}) async {
  await FirebaseFirestore.instance
      .collection("during")
      .doc(teacher)
      .update({"state": "test"});
  await currentLesson.reference.update({"state": "test"});
}

Future<void> finishLessonToDuring(
    {required String teacher, required Lesson currentLesson}) async {
  await FirebaseFirestore.instance.collection("during").doc(teacher).delete();
  await currentLesson.reference.update({"state": "after"});
}

// 現在行われている授業一覧に、指定した（今行っている）授業があればtrue、
// 他の人が同じクラスで授業を行っている場合はfalse、
// 同じクラスで誰も授業を行っていなければnullを返す
bool? duringLesson({
  required List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotData,
  required String roomNumber,
  required String subject,
  required int count,
}) {
  for (var d in snapshotData) {
    var map = d.data();
    if (map["room"] == roomNumber) {
      return map["subject"] == subject && map["count"] == count;
    }
  }
  return null;
}

bool duringLessonNotCount({
  required List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotData,
  required String roomNumber,
  required String subject,
}) {
  for (var d in snapshotData) {
    var map = d.data();
    if (map["room"] == roomNumber) {
      return map["subject"] == subject;
    }
  }
  return false;
}

String? givingLesson({
  required List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshotData,
  required String teacher,
}) {
  for (var d in snapshotData) {
    var map = d.data();
    if (map["teacher"] == teacher) {
      return map["state"];
    }
  }
  return null;
}
