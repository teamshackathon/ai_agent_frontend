import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teacher.freezed.dart';

part 'teacher.g.dart';

// 教師用クラス
// firestoreのteachersにnameが入っている想定
@freezed
class Teacher with _$Teacher {
  const Teacher._();

  const factory Teacher({
    required String id,
    required String name,
    // [ { "room": "~", "year": "~", "subject": "~" }, ... ]
    required List<Map<String, String>> teach,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}

// 教師用プロバイダー
@Riverpod(keepAlive: true)
class Teachers extends _$Teachers {
  @override
  List<Teacher> build() => [];

  ///stateを空リストに変更
  void init() => state = [];

  ///stateにRoomを追加
  void add(Teacher teacher) => state = [...state, teacher];

  Teacher? inChargeOf(String room, String year, String subject) {
    for (var teacher in state) {
      for (var t in teacher.teach) {
        if (t["room"] == room && t["year"] == year && t["subject"] == subject)
          return teacher;
      }
    }
    return null;
  }
}
