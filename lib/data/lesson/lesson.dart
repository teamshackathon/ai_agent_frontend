import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../agenda/agenda.dart';

part 'lesson.freezed.dart';

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  const factory Lesson({
    required int count,
    required Agenda publishAgenda,
    required Agenda draftAgenda,
    required DocumentReference reference,
  }) = _Lesson;

  factory Lesson.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data();
    return Lesson(
      reference: snapshot.reference,
      publishAgenda: Agenda.fromMap(map?["agenda_publish"] ?? {}),
      draftAgenda: Agenda.fromMap(map?["agenda_draft"] ?? {}),
      count: map?["count"] ?? 0,
    );
  }

  // 基本使わない
  Map<String, dynamic> toMap() {
    return {
      // countに関してはfirestore packageに同名のクラス？メソッド？があるっぽいので
      // thisをつけることで、このクラスの引数であることを示す必要がある
      "count": this.count,
      "agenda_publish": publishAgenda.toMap(),
      "agenda_draft": draftAgenda.toMap(),
    };
  }

  factory Lesson.isBlank() {
    return Lesson(
      count: 0,
      publishAgenda: Agenda.isBlank(),
      draftAgenda: Agenda.isBlank(),
      reference: FirebaseFirestore.instance.collection("2024").doc(),
    );
  }
}
