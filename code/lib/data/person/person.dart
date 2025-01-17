import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person.freezed.dart';

part 'person.g.dart';

@freezed
class Person with _$Person {
  const Person._();

  /// テスト
  const factory Person({
    required String id,
    required String name,
    required String role,
    required List<String> roomIdList,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}


@Riverpod(keepAlive: true)
class PersonStatus extends _$PersonStatus {
  @override
  Person build() => Person(id: "", name: "", role: "", roomIdList: []);

  void init() => state = Person(id: "", name: "", role: "", roomIdList: []);

  void write(Person person) => state = person;
}

