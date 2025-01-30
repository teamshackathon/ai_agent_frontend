import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 選択されたlessonのtoolsへのPathを保持しておくプロバイダー
final currentLessonRefProvider = StateProvider<DocumentReference>((ref) {
  // nullにすると面倒くさいから適当なPATHをいれている(危なそう)
  return FirebaseFirestore.instance.collection("2024").doc();
});

// // CurrentLessonRefで指定したcollectionを監視するプロバイダー
// final toolStreamProvider = StreamProvider(
//       (ref) {
//     final reference = ref.watch(currentLessonRefProvider);
//     return reference
//         .withConverter<Lesson>(
//       fromFirestore: ((snapshot, _) => Lesson.fromFirestore(snapshot)),
//       toFirestore: ((lesson, _) => lesson.toMap()),
//     )
//         .orderBy("count", descending: true)
//         .snapshots();
//   },
// );
