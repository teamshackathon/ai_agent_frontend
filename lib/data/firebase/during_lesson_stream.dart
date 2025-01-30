import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/person/person.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final duringLessonRefProvider = FutureProvider<DocumentReference>((ref) async{
  final user = await ref.watch(personStatusProvider.future);
  if(user is Student){
    return FirebaseFirestore.instance.collection("2024").doc(user.rooms[0]["room"]);
  }else if(user is Teacher){
    final currentRoom = ref.watch(currentRoomRefProvider);
    return currentRoom.parent?.parent.parent ?? FirebaseFirestore.instance.collection("2024").doc();
  }
  // nullにすると面倒くさいから適当なPATHをいれている(危なそう)
  return FirebaseFirestore.instance.collection("2024").doc();
});

final duringLessonStreamProvider = StreamProvider((ref){
  final reference = ref.watch(duringLessonRefProvider);
  return reference.
});