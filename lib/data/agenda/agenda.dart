import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part "agenda.freezed.dart";
//
// @freezed
// class Agenda with _$Agenda {
//   const Agenda._();
//
//   const factory Agenda({
//     required String title,
//     required List<Map<String,String>> agenda,
//   }) = _Agenda;
//
//   factory Agenda.fromFirestore(
//       DocumentSnapshot<Map<String, dynamic>> snapshot) {
//     final map = snapshot.data()?["agenda_draft"];
//     final List<Map<String,String>> list = [];
//     for(var d in map)
//     return Agenda(
//       title: map?["title"] ?? "",
//       agenda:
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       "title": title,
//       "time": time,
//       "steps": steps,
//     };
//   }
// }
