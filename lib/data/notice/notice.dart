import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification.freezed.dart';

part 'notification.g.dart';

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  // とりあえずidと回数だけ持ってる
  const factory Lesson({
    required String id,
    required int count,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  String get displayCount => "第$count回";
}

@Riverpod(keepAlive: true)
class Lessons extends _$Lessons {
  @override
  List<Lesson> build() => [];

  void init() => state = [];

  void add(Lesson lesson) => state = [...state, lesson];
}
