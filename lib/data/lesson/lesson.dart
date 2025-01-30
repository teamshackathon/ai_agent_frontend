import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lesson.freezed.dart';

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  // とりあえずidと回数だけ持ってる
  const factory Lesson({
    required int count,
    required DocumentReference reference,
  }) = _Lesson;

  factory Lesson.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data();
    return Lesson(
      reference: snapshot.reference,
      count: map?["count"] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {"count": this.count};
  }
}
