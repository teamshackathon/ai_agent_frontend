import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../lesson/lesson.dart';

// 選択されたroomのlessonsへのPathを保持しておくプロバイダー
final currentRoomRefProvider = StateProvider<CollectionReference>((ref) {
  return FirebaseFirestore.instance.collection("2024");
});

// CurrentRoomReferenceで指定したcollectionを監視するプロバイダー
final lessonStreamProvider = StreamProvider(
  (ref) {
    final reference = ref.watch(currentRoomRefProvider);
    return reference
        .withConverter<Lesson>(
          fromFirestore: ((snapshot, _) => Lesson.fromFirestore(snapshot)),
          toFirestore: ((lesson, _) => lesson.toMap()),
        )
        .orderBy("count", descending: true)
        .snapshots();
  },
);
