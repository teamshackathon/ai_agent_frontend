import 'package:code/data/result/result.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'quiz.freezed.dart';

part 'quiz.g.dart';

@freezed
class Quiz with _$Quiz {
  const Quiz._();

  const factory Quiz({
    required String title,
    required String question,
    required String correctAnswer,
    required int score,
    @Default("") String answer,
    @Default(false) bool correct,
    @Default(false) bool reloadFlag,
  }) = _Quiz;

  const factory Quiz.sentaku({
    required String title,
    required String question,
    required String correctAnswer,
    required List<Option> options,
    required int score,
    @Default("") String answer,
    @Default(false) bool correct,
    @Default(false) bool reloadFlag,
  }) = Sentaku;

  const factory Quiz.anaume({
    required String title,
    required String question,
    required String correctAnswer,
    required int score,
    @Default("") String answer,
    @Default(false) bool correct,
    @Default(false) bool reloadFlag,
  }) = Anaume;

  const factory Quiz.kijutsu({
    required String title,
    required String question,
    required String correctAnswer,
    required int score,
    @Default("") String answer,
    @Default(false) bool correct,
    @Default(false) bool reloadFlag,
  }) = Kijutsu;

  factory Quiz.fromMap(Map<String, dynamic> map) {
    if (map["format"] == "Anaume") {
      return Anaume(
        title: map["title"] ?? "",
        question: map["question"] ?? "",
        correctAnswer: map["correct_answer"] ?? "",
        score: map["score"] ?? 0,
        answer: map["answer"] ?? "",
        correct: map["correct"] ?? false,
        reloadFlag: map["reloadFlag"] ?? false,
      );
    } else if (map["format"] == "Sentaku") {
      final List<Option> options = [];
      for (var m in map["options"] ?? []) {
        options.add(Option.fromMap(m));
      }
      return Sentaku(
        title: map["title"] ?? "",
        question: map["question"] ?? "",
        correctAnswer: map["correct_answer"] ?? "",
        options: options,
        score: map["score"] ?? 0,
        answer: map["answer"] ?? "",
        correct: map["correct"] ?? false,
        reloadFlag: map["reloadFlag"] ?? false,
      );
    } else {
      return Kijutsu(
        title: map["title"] ?? "",
        question: map["question"] ?? "",
        correctAnswer: map["correct_answer"] ?? "",
        score: map["score"] ?? 0,
        answer: map["answer"] ?? "",
        correct: map["correct"] ?? false,
        reloadFlag: map["reloadFlag"] ?? false,
      );
    }
  }
  Map<String, dynamic> answerToMap() {
    return {
      "title": title,
      "answer": answer,
    };
  }

  Map<String, dynamic> toMap() {
    if (this is Anaume) {
      return {
        "title": title,
        "format": "Anaume",
        "score": score,
        "question": question,
        "correct_answer": correctAnswer,
      };
    } else if (this is Sentaku) {
      var correctNum = 0;
      final List<Map<String, dynamic>> list = [];
      for (final option in (this as Sentaku).options) {
        list.add(option.toMap());
        if (option.word == correctAnswer) correctNum = option.number;
      }
      return {
        "title": title,
        "format": "Sentaku",
        "score": score,
        "question": question,
        "correct_answer": correctAnswer,
        "correct_num": correctNum,
        "options": list,
      };
    } else {
      return {
        "title": title,
        "format": "Kijutsu",
        "score": score,
        "question": question,
        "correct_answer": correctAnswer,
      };
    }
  }

  factory Quiz.isBlank() {
    return Quiz(
      title: "",
      question: "",
      correctAnswer: "",
      score: -1,
    );
  }
}

@freezed
class Option with _$Option {
  const Option._();

  const factory Option({
    required int number,
    required String word,
  }) = _Option;

  factory Option.fromMap(Map<String, dynamic> map) {
    return Option(
      number: int.parse(map["item_num"].toString()),
      word: map["item_word"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "item_num": number,
      "item_word": word,
    };
  }
}

@Riverpod(keepAlive: true)
class QuizNotifier extends _$QuizNotifier {
  // ToDo(iga)
  // build時にAPIの情報を読み込む
  @override
  List<Quiz> build() => [];

  void rebuild() => state = [];

  void init(List<Quiz> list) {
    rebuild();
    for (var quiz in list) {
      add(quiz);
    }
  }

  void add(Quiz quiz) {
    state = [...state, quiz];
  }

  Quiz fromJsonDetectFormat(Map<String, dynamic> json) {
    return Quiz.fromMap(json);
  }

  void readResult(List<Result> result) {
    for (final rs in result) {
      _importResult(rs.title, rs.correct);
    }
  }

  void _importResult(String title, bool correct) {
    state = [
      for (final quiz in state)
        quiz.title == title ? _correctAndCopy(quiz, correct) : quiz
    ];
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

  Quiz _correctAndCopy(Quiz quiz, bool correct) {
    if (quiz is Sentaku) {
      //var numAnswer = int.parse(answer);
      return quiz.copyWith(correct: correct);
    } else if (quiz is Anaume) {
      return quiz.copyWith(correct: correct);
    } else if (quiz is Kijutsu) {
      return quiz.copyWith(correct: correct);
    } else {
      throw FormatException("Quizの型が正しくありません。");
    }
  }

  String getQuestion(int index) {
    return state[index].question;
  }

  void replaceQuiz(Quiz replaceQuiz) {
    state = [
      for (final quiz in state)
        quiz.title == replaceQuiz.title ? replaceQuiz : quiz
    ];
  }

  List<Map<String, dynamic>> quizAnswersToListMap() {
    List<Map<String, dynamic>> list = [];
    for (var q in state) {
      list.add(q.answerToMap());
    }
    return list;
  }
}

class QuizList {
  List<Quiz> value;
  QuizList(this.value);

  Quiz fromJsonDetectFormat(Map<String, dynamic> json) {
    return Quiz.fromMap(json);
  }

  List<Quiz> readResult(List<Result> result) {
    for (final rs in result) {
      _importResult(rs.title, rs.correct);
    }
    return value;
  }

  void _importResult(String title, bool correct) {
    value = [
      for (final quiz in value)
        quiz.title == title ? _correctAndCopy(quiz, correct) : quiz
    ];
  }

  QuizList writeAnswer(String title, String answer) {
    value = [
      for (final quiz in value)
        quiz.title == title ? _answerAndCopy(quiz, answer) : quiz
    ];

    return QuizList(value);
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

  Quiz _correctAndCopy(Quiz quiz, bool correct) {
    if (quiz is Sentaku) {
      //var numAnswer = int.parse(answer);
      return quiz.copyWith(correct: correct);
    } else if (quiz is Anaume) {
      return quiz.copyWith(correct: correct);
    } else if (quiz is Kijutsu) {
      return quiz.copyWith(correct: correct);
    } else {
      throw FormatException("Quizの型が正しくありません。");
    }
  }

  String getQuestion(int index) {
    return value[index].question;
  }

  List<Quiz> replaceQuiz(Quiz replaceQuiz) {
    value = [
      for (final quiz in value)
        quiz.title == replaceQuiz.title ? replaceQuiz : quiz
    ];
    return value;
  }

  List<Map<String, dynamic>> quizAnswersToListMap() {
    List<Map<String, dynamic>> list = [];
    for (var q in value) {
      list.add(q.answerToMap());
    }
    return list;
  }
}
