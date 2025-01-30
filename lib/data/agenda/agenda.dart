import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "agenda.freezed.dart";

@freezed
class Agenda with _$Agenda{
  const Agenda._();

  const factory Agenda({
    required String title,
    required String time,
    required String steps,
  }) = _Agenda;

  factory Agenda.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data();
    return Agenda(
      title: map?["title"] ?? "",
      time: map?["time"] ?? "",
      steps: map?["steps"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title":title,
      "time":time,
      "steps":steps,
    };
  }
}