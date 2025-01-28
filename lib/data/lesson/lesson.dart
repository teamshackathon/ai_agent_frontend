import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lesson.freezed.dart';

part 'lesson.g.dart';

@freezed
class Lesson with _$Lesson {
  const Lesson._();

  const factory Lesson(
      {required String id,
      required int count,
      required String roomId,
      required String status,
      required String quizId}) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@Riverpod(keepAlive: true)
class Lessons extends _$Lessons {
  @override
  List<Lesson> build() => [];

  void reset() => state = [];

  void add(Lesson lesson) => state = [...state, lesson];

  Lesson currentLesson(){
    return state[0];
  }
}
