import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../quiz/quiz.dart';

part 'result.freezed.dart';

@freezed
class Result with _$Result {
  const Result._();

  const factory Result({
    // 採点済みかどうか
    required bool graded,
    required String title,
    required bool correct,
    required String answer,
    required String correctAnswer,
    required String description,
  }) = _Result;

  factory Result.fromMap(Map<String, dynamic> map, bool graded) {
    return Result(
      graded: graded,
      title: map["title"] ?? "",
      correct: map["correct"] ?? false,
      answer: map["user_answer"] ?? map["answer"] ?? "",
      correctAnswer: map["correct_answer"] ?? "",
      description: map["discription"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "correct": correct,
      "user_answer": answer,
      "correct_answer": correctAnswer,
      "discription": description,
    };
  }

  factory Result.isBlank() {
    return Result(
      graded: false,
      title: "",
      correct: false,
      answer: "",
      correctAnswer: "",
      description: "",
    );
  }
}

List<Result> sortWithQuizzes(List<Result> results, List<Quiz> quizzes) {
  final List<Result> sort = [];

  for (final q in quizzes) {
    sort.add(results.firstWhere((r) => r.title == q.title));
  }

  return sort;
}
