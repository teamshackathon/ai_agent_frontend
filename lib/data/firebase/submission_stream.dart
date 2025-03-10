import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../person/person.dart';
import '../submission/submission.dart';
import 'tools_stream.dart';

final submissionStreamProvider = StreamProvider((ref) async* {
  final reference = ref.watch(currentLessonProvider).reference;
  final user = await ref.watch(personStatusProvider.future);
  if (user is Student) {
    yield* reference
        .collection("students")
        .where("name", isEqualTo: user.name)
        .withConverter(
          fromFirestore: (snapshot, _) => Submission.fromFirestore(snapshot),
          toFirestore: (submission, _) => submission.toFirestore(),
        )
        .snapshots();
  } else {
    yield* reference
        .collection("students")
        .withConverter(
          fromFirestore: (snapshot, _) => Submission.fromFirestore(snapshot),
          toFirestore: (submission, _) => submission.toFirestore(),
        )
        .snapshots();
  }
});
