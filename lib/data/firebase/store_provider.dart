import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakura/toast.dart';

import '../lesson/lesson.dart';
import '../notice/notice.dart';
import '../person/person.dart';

/// firestoreのインスタンス監視用プロバイダー
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// noticeコレクションへの参照を持つset専用プロバイダー
///
/// 色々改良の余地がありそうだけど、一旦はこれで
final noticeSetReferenceProvider = Provider.autoDispose((ref) {
  final store = ref.watch(firestoreProvider);

  // noticeコレクションにまとめて入れるため、set,getで参照元が異なる
  return store.collection("notice").withConverter<Notice>(
        fromFirestore: ((snapshot, _) => Notice.fromFirestore(snapshot)),
        toFirestore: ((notice, _) => notice.toMap()),
      );
});

/// Claudeを崇拝せよ
final noticeStudentGetProvider = StreamProvider((ref) async* {
  final store = FirebaseFirestore.instance;
  final student = await ref.watch(personStatusProvider.future) as Student;

  // QueryをStreamとして直接返す
  yield* store
      .collection("notice")
      .where("room", isEqualTo: student.rooms[0]["room"])
      .where("folderName", isEqualTo: student.folderName)
      .limit(20)
      .withConverter<Notice>(
        fromFirestore: ((snapshot, _) => Notice.fromFirestore(snapshot)),
        toFirestore: ((notice, _) => notice.toMap()),
      )
      .snapshots();
});

final noticeTeacherGetProvider = StreamProvider((ref) async* {
  final store = ref.watch(firestoreProvider);
  final teacher = await ref.watch(personStatusProvider.future) as Teacher;

  // QueryをStreamとして直接返す
  yield* store
      .collection("notice")
      .where("folderName", isEqualTo: teacher.folderName)
      .limit(20)
      .withConverter<Notice>(
        fromFirestore: ((snapshot, _) => Notice.fromFirestore(snapshot)),
        toFirestore: ((notice, _) => notice.toMap()),
      )
      .snapshots();
});
