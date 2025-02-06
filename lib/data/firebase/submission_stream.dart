import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/person/person.dart';
import 'package:code/data/submission/submission.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final submissionStreamProvider = StreamProvider((ref) async* {
  final reference = ref.watch(currentLessonStreamProvider)?.reference ??
      FirebaseFirestore.instance.collection("2024").doc("common");
  final user = await ref.watch(personStatusProvider.future);
  if (user is Student) {
    yield* reference
        .collection("student")
        .where("name", isEqualTo: user.folderName)
        .withConverter(
          fromFirestore: (snapshot, _) => Submission.fromFirestore(snapshot),
          toFirestore: (submission, _) => submission.toFirestore(),
        )
        .snapshots();
  } else {
    yield* reference
        .collection("student")
        .withConverter(
          fromFirestore: (snapshot, _) => Submission.fromFirestore(snapshot),
          toFirestore: (submission, _) => submission.toFirestore(),
        )
        .snapshots();
  }
});
