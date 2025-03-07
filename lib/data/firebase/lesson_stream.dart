import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../lesson/lesson.dart';
import '../room/room.dart';

// 選択されたroomのlessonsへのPathを保持しておくプロバイダー
final currentRoomProvider = StateProvider<Room>((ref) {
  // nullにすると面倒くさいから適当なデータをいれている(危なそう)
  return Room.isBlank();
});

// CurrentRoomProviderで指定したcollectionを監視するプロバイダー
final lessonsStreamProvider = StreamProvider(
  (ref) {
    final reference = ref.watch(currentRoomProvider).reference;
    return reference
        .withConverter<Lesson>(
          fromFirestore: ((snapshot, _) => Lesson.fromFirestore(snapshot)),
          toFirestore: ((lesson, _) => lesson.toMap()),
        )
        .orderBy("count", descending: true)
        .snapshots();
  },
);
