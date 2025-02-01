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
        score: map["score"] ?? -1,
        answer: map["answer"] ?? "",
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
        score: map["score"] ?? -1,
        answer: map["answer"] ?? "",
      );
    } else {
      return Kijutsu(
        title: map["title"] ?? "",
        question: map["question"] ?? "",
        correctAnswer: map["correct_answer"] ?? "",
        score: map["score"] ?? -1,
        answer: map["answer"] ?? "",
      );
    }
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

  void init(List<Map<String, dynamic>> list) {
    rebuild();
    for (var quizJson in list) {
      add(fromJsonDetectFormat(quizJson));
    }
  }

  void add(Quiz quiz) {
    state = [...state, quiz];
  }

  Quiz fromJsonDetectFormat(Map<String, dynamic> json) {
    return Quiz.fromMap(json);
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

  void replaceQuiz(Quiz replaceQuiz) {
    state = [
      for (final quiz in state)
        quiz.title == replaceQuiz.title ? replaceQuiz : quiz
    ];
  }
}

// TODO
// 読み込みできるようにお願いします　to蓮見
List<Map<String, dynamic>> readQuiz(String lessonId) {
  return [
    {
      "title": "動詞の使い方",
      "format": "Anaume",
      "score": 25,
      "question": "英語の文で「I _ a book.」と書く場合、空欄にはどの動詞を入れますか？",
      "correctAnswer": "read",
      "answer": "read"
    },
    {
      "title": "疑問文の作り方",
      "format": "Sentaku",
      "score": 25,
      "question": "次の文を疑問文にするにはどの語順を使いますか？「He is a teacher.」",
      "options": [
        {"item_num": "1", "item_word": "Is he a teacher?"},
        {"item_num": "2", "item_word": "He is a teacher?"},
        {"item_num": "3", "item_word": "A teacher is he?"}
      ],
      "correctAnswer": "Is he a teacher?",
      "correctNum": 1,
      "answer": "He is a teacher?"
    },
    {
      "title": "名詞の複数形",
      "format": "Kijutsu",
      "score": 25,
      "question": "「cat」の複数形は何ですか？",
      "correctAnswer": "cats",
      "answer": "cas?"
    },
    {
      "title": "時間の表現",
      "format": "Anaume",
      "score": 25,
      "question": "英語で「今は3時です」と言いたい場合、空欄には何が入りますか？「It is _ o'clock.」",
      "correctAnswer": "three",
      "answer": "san?"
    },
  ];
}
