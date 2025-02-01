import 'package:freezed_annotation/freezed_annotation.dart';

part "agenda.freezed.dart";

@freezed
class Agenda with _$Agenda {
  const Agenda._();

  const factory Agenda({
    required String title,
    required List<Sentence> sentences,
  }) = _Agenda;

  factory Agenda.fromMap(Map<String, dynamic> map) {
    final List<Sentence> list = [];
    for (var d in map["agenda"] ?? []) {
      list.add(Sentence.fromMap(d));
    }
    return Agenda(
      title: map["title"] ?? "",
      sentences: list,
    );
  }

  Map<String, dynamic> toMap() {
    final List<Map<String, dynamic>> list = [];
    for (var d in sentences) {
      list.add(d.toMap());
    }
    return {
      "title": title,
      "agenda": list,
    };
  }

  factory Agenda.isBlank() => Agenda(title: "", sentences: []);
}

@freezed
class Sentence with _$Sentence {
  const Sentence._();

  const factory Sentence({
    required String subtitle,
    required int time,
    required String description,
  }) = _Sentence;

  factory Sentence.fromMap(Map<String, dynamic> map) {
    return Sentence(
      subtitle: map["subtitle"] ?? "",
      time: map["time"] ?? 0,
      description: map["description"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "subtitle": subtitle,
      "time": time,
      "description": description,
    };
  }
}
