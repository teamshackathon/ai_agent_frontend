import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../agenda/agenda.dart';
import '../quiz/quiz.dart';

part 'lesson.freezed.dart';

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  const factory Lesson({
    required int count,
    required Agenda agendaPublish,
    required Agenda agendaDraft,
    required Quiz questionsPublish,
    required Quiz questionsDraft,
    required DocumentReference reference,
  }) = _Lesson;

  factory Lesson.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data();
    return Lesson(
      reference: snapshot.reference,
      agendaPublish: Agenda.fromMap(map?["agenda_publish"] ?? {}),
      agendaDraft: Agenda.fromMap(map?["agenda_draft"] ?? {}),
      questionsPublish: Quiz.fromMap(map?["questions_publish"] ?? {}),
      questionsDraft: Quiz.fromMap(map?["questions_draft"] ?? {}),
      count: map?["count"] ?? -1,
    );
  }

  // 基本使わない
  Map<String, dynamic> toMap() {
    return {
      // countに関してはfirestore packageに同名のクラス？メソッド？があるっぽいので
      // thisをつけることで、このクラスの引数であることを示す必要がある
      "count": this.count,
      "agenda_publish": agendaPublish.toMap(),
      "agenda_draft": agendaDraft.toMap(),
      "questions_publish":questionsPublish.toMap(),
      "questions_draft":questionsDraft.toMap(),
    };
  }

  factory Lesson.isBlank() {
    return Lesson(
      count: 0,
      agendaPublish: Agenda.isBlank(),
      agendaDraft: Agenda.isBlank(),
      questionsPublish: Quiz.isBlank(),
      questionsDraft: Quiz.isBlank(),
      reference: FirebaseFirestore.instance.collection("2024").doc(),
    );
  }
}
