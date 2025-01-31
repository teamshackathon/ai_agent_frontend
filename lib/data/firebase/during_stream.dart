import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/person/person.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
