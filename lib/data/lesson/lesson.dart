import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../agenda/agenda.dart';
import '../quiz/quiz.dart';
import '../summary/summary.dart';

part 'lesson.freezed.dart';

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  const factory Lesson({
    required int count,
    required Agenda agendaPublish,
    required Agenda agendaDraft,
    required List<Quiz> questionsPublish,
    required List<Quiz> questionsDraft,
    required Summary summary,
    required DocumentReference reference,
    required int startPage,
    required int endPage,
    // before, lesson, break, test, afterの５状態
    required String state,
  }) = _Lesson;

  factory Lesson.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final map = snapshot.data();
    final List<Quiz> publish = [
      for (var m in map?["questions_publish"] ?? []) Quiz.fromMap(m)
    ];
    final List<Quiz> draft = [
      for (var m in map?["questions_draft"] ?? []) Quiz.fromMap(m)
    ];

    return Lesson(
      reference: snapshot.reference,
      agendaPublish: Agenda.fromMap(map?["agenda_publish"] ?? {}),
      agendaDraft: Agenda.fromMap(map?["agenda_draft"] ?? {}),
      questionsPublish: publish,
      questionsDraft: draft,
      summary: Summary.fromMap(map?["summary"] ?? {}),
      count: map?["count"] ?? 0,
      startPage: map?["start_page"] ?? 0,
      endPage: map?["end_page"] ?? 0,
      state: map?["state"] ?? "",
    );
  }

  // 基本使わない
  Map<String, dynamic> toMap() {
    final publish = [for (var q in questionsPublish) q.toMap()];
    final draft = [for (var q in questionsDraft) q.toMap()];
    return {
      // countに関してはfirestore packageに同名のクラス？メソッド？があるっぽいので
      // thisをつけることで、このクラスの引数であることを示す必要がある
      "count": this.count,
      "agenda_publish": agendaPublish.toMap(),
      "agenda_draft": agendaDraft.toMap(),
      "questions_publish": publish,
      "questions_draft": draft,
      "start_page": startPage,
      "end_page": endPage,
      "state": state,
    };
  }

  factory Lesson.isBlank() {
    return Lesson(
      count: 0,
      agendaPublish: Agenda.isBlank(),
      agendaDraft: Agenda.isBlank(),
      questionsPublish: [],
      questionsDraft: [],
      summary: Summary.isBlank(),
      reference: FirebaseFirestore.instance.collection("2024").doc(),
      startPage: 0,
      endPage: 0,
      state: "",
    );
  }

  List<Map<String, dynamic>> get publishMap =>
      [for (final d in questionsDraft) d.toMap()];
}
