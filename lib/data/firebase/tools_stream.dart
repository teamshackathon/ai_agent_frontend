import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../lesson/lesson.dart';

final currentLessonProvider = StateProvider<Lesson>((ref) {
  return Lesson.isBlank();
});

// 選択した授業内容を監視するプロバイダー
// lessonsStreamProviderの支流を作るイメージ
final toolsStreamProvider = StreamProvider(
  (ref) {
    final reference = ref.watch(currentLessonProvider).reference;
    return reference
        .withConverter<Lesson>(
          fromFirestore: ((snapshot, _) => Lesson.fromFirestore(snapshot)),
          toFirestore: ((lesson, _) => lesson.toMap()),
        )
        .snapshots();
  },
);

final testLessonProvider = StateProvider<DocumentReference>((ref) {
  return FirebaseFirestore.instance
      .collection("2024")
      .doc("1-1")
      .collection("common")
      .doc("english")
      .collection("lessons")
      .doc("4UqKejHwR6jrPXdtzlY0");
});

final testToolsStreamProvider = StreamProvider((ref) {
  final reference = ref.watch(testLessonProvider);
  return reference
      .withConverter<Lesson>(
        fromFirestore: ((snapshot, _) => Lesson.fromFirestore(snapshot)),
        toFirestore: ((lesson, _) => lesson.toMap()),
      )
      .snapshots();
});
