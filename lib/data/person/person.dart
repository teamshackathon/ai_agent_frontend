import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person.freezed.dart';

part 'person.g.dart';

@freezed
class Person with _$Person {
  const Person._();

  /// 生徒、先生情報
  const factory Person({
    required String uid,
    required String name,
    required String role,
    String? firstName,
    String? familyName,
    String? room,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

@Riverpod(keepAlive: true)
class PersonStatus extends _$PersonStatus {
  @override
  Person build() => Person(uid: "", name: "", role: "");

  ///stateを空リストに変更
  void init() => state = Person(uid: "", name: "", role: "");

  ///stateにpersonを上書き
  void write(Person person) => state = person;
}
