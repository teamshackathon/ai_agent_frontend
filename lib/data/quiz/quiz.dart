import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class Quiz with _$Quiz {
  const Quiz._();

  const factory Quiz.sentaku({
    required String title,
    required String format,
    required String question,
    required String correctAnswer,
    required List<Map<String, Object>> options,
    required int score,
    @Default("") String answer,
    @Default(false) bool correct,
    @Default(false) bool reloadFlag,
  }) = Sentaku;

  const factory Quiz.anaume({
    required String title,
    required String format,
    required String question,
    required String correctAnswer,
    required int score,
    @Default("") String answer,
    @Default(false) bool correctF,
    @Default(false) bool reloadFlag,
  }) = Anaume;

  const factory Quiz.kijutsu({
    required String title,
    required String format,
    required String question,
    required String correctAnswer,
    required int score,
    @Default("") String answer,
    @Default(false) bool correct,
    @Default(false) bool reloadFlag,
  }) = Kijutsu;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}

@Riverpod(keepAlive: true)
class QuizNotifer extends _$QuizNotifer {
  // ToDo(iga)
  // build時にAPIの情報を読み込む
  @override
  List<Quiz> build() => [];

  void rebuild() => state = [];

  Quiz fromJsonDetectFormat(Map<String, dynamic> json) {
    if (json["format"] == "Sentaku") {
      return Sentaku.fromJson(json);
    } else if (json["format"] == "Anaume") {
      return Anaume.fromJson(json);
    } else if (json["format"] == "Kijutsu") {
      return Kijutsu.fromJson(json);
    } else {
      throw FormatException("formatが正しくありません。");
    }
  }

  void writeAnswer(String title, String answer) {
    state = [
      for (final quiz in state)
        quiz.title == title ? _answerAndCopy(quiz, answer) : quiz
    ];
  }

  Quiz _answerAndCopy(Quiz quiz, String answer) {
    if (quiz is Sentaku) {
      //var numAnswer = int.parse(answer);
      return quiz.copyWith(answer: answer);
    } else if (quiz is Anaume) {
      return quiz.copyWith(answer: answer);
    } else if (quiz is Kijutsu) {
      return quiz.copyWith(answer: answer);
    } else {
      throw FormatException("Quizの型が正しくありません。");
    }
  }

  String getQuestion(int index) {
    return state[index].question;
  }
}

List<Map<String, dynamic>> readQuiz(String lessonId) {
  return [
    {
      "title": "動詞の使い方",
      "format": "Anaume",
      "question": "英語の文で「I _ a book.」と書く場合、空欄にはどの動詞を入れますか？",
      "correctAnswer": "read"
    },
    {
      "title": "疑問文の作り方",
      "format": "Sentaku",
      "question": "次の文を疑問文にするにはどの語順を使いますか？「He is a teacher.」",
      "options": [
        {"item_num": 1, "item_word": "Is he a teacher?"},
        {"item_num": 2, "item_word": "He is a teacher?"},
        {"item_num": 3, "item_word": "A teacher is he?"}
      ],
      "correctAnswer": "Is he a teacher?",
      "correct_num": 1
    },
  ];
}
