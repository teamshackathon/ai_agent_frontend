import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../lesson/lesson.dart';
import 'auth_provider.dart';

final duringStreamProvider = StreamProvider((ref) async* {
  final reference = FirebaseFirestore.instance.collection("during");
  final authState = ref.watch(authStateProvider);
  final user = authState.value;
  if (user == null) yield* reference.snapshots();
  final token = await user!.getIdTokenResult();
  // 生徒以外はduring全てを持ってくる
  if (token.claims?["role"] != "student") yield* reference.snapshots();

  // 生徒は現在の自分のクラスのduringだけ見るようにしてある
  final list = token.claims?["rooms"] ?? [];
  if (list.isEmpty) yield* reference.snapshots();
  list.sort((a, b) => -int.parse(a["year"]!).compareTo(int.parse(b["year"]!)));
  yield* reference.where("room", isEqualTo: list[0]["room"]).snapshots();
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
    "finish": [],
    "reference": currentLesson.reference,
  });
  await currentLesson.reference.update({"state": "lesson"});
}

Future<void> cancelLessonToDuring(
    {required String teacher, required DocumentReference reference}) async {
  await FirebaseFirestore.instance.collection("during").doc(teacher).delete();
  await reference.update({"state": "before"});
}

Future<void> breakLessonToDuring(
    {required String teacher, required DocumentReference reference}) async {
  await FirebaseFirestore.instance
      .collection("during")
      .doc(teacher)
      .update({"state": "break"});
  await reference.update({"state": "break"});
}

Future<void> startTestToDuring(
    {required String teacher, required DocumentReference reference}) async {
  await FirebaseFirestore.instance
      .collection("during")
      .doc(teacher)
      .update({"state": "test"});
  await reference.update({"state": "test"});
}

Future<void> finishLessonToDuring(
    {required String teacher, required DocumentReference reference}) async {
  await FirebaseFirestore.instance.collection("during").doc(teacher).delete();
  await reference.update({"state": "after"});
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

Map<String, dynamic>? getMeFromDuring({
  required List<QueryDocumentSnapshot<Map<String, dynamic>>> queryList,
  required String name,
}) {
  for(final q in queryList){
    final data = q.data();
    if(data["teacher"] == name)return data;
  }
  return null;
}
