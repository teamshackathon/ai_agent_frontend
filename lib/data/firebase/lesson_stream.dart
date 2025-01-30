import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../lesson/lesson.dart';

// 選択されたroomのlessonsへのPathを保持しておくプロバイダー
final currentRoomRefProvider = StateProvider<CollectionReference>((ref) {
  // nullにすると面倒くさいから適当なPATHをいれている(危なそう)
  return FirebaseFirestore.instance.collection("2024");
});

// CurrentRoomRefProviderで指定したcollectionを監視するプロバイダー
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
