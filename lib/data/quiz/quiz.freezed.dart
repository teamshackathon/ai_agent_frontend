// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Quiz {
  String get title => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  bool get correct => throw _privateConstructorUsedError;
  bool get reloadFlag => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        sentaku,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        anaume,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        kijutsu,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Sentaku value) sentaku,
    required TResult Function(Anaume value) anaume,
    required TResult Function(Kijutsu value) kijutsu,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Sentaku value)? sentaku,
    TResult? Function(Anaume value)? anaume,
    TResult? Function(Kijutsu value)? kijutsu,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Sentaku value)? sentaku,
    TResult Function(Anaume value)? anaume,
    TResult Function(Kijutsu value)? kijutsu,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuizCopyWith<Quiz> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizCopyWith<$Res> {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) then) =
      _$QuizCopyWithImpl<$Res, Quiz>;
  @useResult
  $Res call(
      {String title,
      String question,
      String correctAnswer,
      int score,
      String answer,
      bool correct,
      bool reloadFlag});
}

/// @nodoc
class _$QuizCopyWithImpl<$Res, $Val extends Quiz>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? score = null,
    Object? answer = null,
    Object? correct = null,
    Object? reloadFlag = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
      reloadFlag: null == reloadFlag
          ? _value.reloadFlag
          : reloadFlag // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentakuImplCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$$SentakuImplCopyWith(
          _$SentakuImpl value, $Res Function(_$SentakuImpl) then) =
      __$$SentakuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String question,
      String correctAnswer,
      List<Option> options,
      int score,
      String answer,
      bool correct,
      bool reloadFlag});
}

/// @nodoc
class __$$SentakuImplCopyWithImpl<$Res>
    extends _$QuizCopyWithImpl<$Res, _$SentakuImpl>
    implements _$$SentakuImplCopyWith<$Res> {
  __$$SentakuImplCopyWithImpl(
      _$SentakuImpl _value, $Res Function(_$SentakuImpl) _then)
      : super(_value, _then);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? options = null,
    Object? score = null,
    Object? answer = null,
    Object? correct = null,
    Object? reloadFlag = null,
  }) {
    return _then(_$SentakuImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<Option>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
      reloadFlag: null == reloadFlag
          ? _value.reloadFlag
          : reloadFlag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SentakuImpl extends Sentaku with DiagnosticableTreeMixin {
  const _$SentakuImpl(
      {required this.title,
      required this.question,
      required this.correctAnswer,
      required final List<Option> options,
      required this.score,
      this.answer = "",
      this.correct = false,
      this.reloadFlag = false})
      : _options = options,
        super._();

  @override
  final String title;
  @override
  final String question;
  @override
  final String correctAnswer;
  final List<Option> _options;
  @override
  List<Option> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int score;
  @override
  @JsonKey()
  final String answer;
  @override
  @JsonKey()
  final bool correct;
  @override
  @JsonKey()
  final bool reloadFlag;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Quiz.sentaku(title: $title, question: $question, correctAnswer: $correctAnswer, options: $options, score: $score, answer: $answer, correct: $correct, reloadFlag: $reloadFlag)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Quiz.sentaku'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('correct', correct))
      ..add(DiagnosticsProperty('reloadFlag', reloadFlag));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentakuImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.reloadFlag, reloadFlag) ||
                other.reloadFlag == reloadFlag));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      question,
      correctAnswer,
      const DeepCollectionEquality().hash(_options),
      score,
      answer,
      correct,
      reloadFlag);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentakuImplCopyWith<_$SentakuImpl> get copyWith =>
      __$$SentakuImplCopyWithImpl<_$SentakuImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        sentaku,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        anaume,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        kijutsu,
  }) {
    return sentaku(title, question, correctAnswer, options, score, answer,
        correct, reloadFlag);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
  }) {
    return sentaku?.call(title, question, correctAnswer, options, score, answer,
        correct, reloadFlag);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
    required TResult orElse(),
  }) {
    if (sentaku != null) {
      return sentaku(title, question, correctAnswer, options, score, answer,
          correct, reloadFlag);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Sentaku value) sentaku,
    required TResult Function(Anaume value) anaume,
    required TResult Function(Kijutsu value) kijutsu,
  }) {
    return sentaku(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Sentaku value)? sentaku,
    TResult? Function(Anaume value)? anaume,
    TResult? Function(Kijutsu value)? kijutsu,
  }) {
    return sentaku?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Sentaku value)? sentaku,
    TResult Function(Anaume value)? anaume,
    TResult Function(Kijutsu value)? kijutsu,
    required TResult orElse(),
  }) {
    if (sentaku != null) {
      return sentaku(this);
    }
    return orElse();
  }
}

abstract class Sentaku extends Quiz {
  const factory Sentaku(
      {required final String title,
      required final String question,
      required final String correctAnswer,
      required final List<Option> options,
      required final int score,
      final String answer,
      final bool correct,
      final bool reloadFlag}) = _$SentakuImpl;
  const Sentaku._() : super._();

  @override
  String get title;
  @override
  String get question;
  @override
  String get correctAnswer;
  List<Option> get options;
  @override
  int get score;
  @override
  String get answer;
  @override
  bool get correct;
  @override
  bool get reloadFlag;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentakuImplCopyWith<_$SentakuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnaumeImplCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$$AnaumeImplCopyWith(
          _$AnaumeImpl value, $Res Function(_$AnaumeImpl) then) =
      __$$AnaumeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String question,
      String correctAnswer,
      int score,
      String answer,
      bool correct,
      bool reloadFlag});
}

/// @nodoc
class __$$AnaumeImplCopyWithImpl<$Res>
    extends _$QuizCopyWithImpl<$Res, _$AnaumeImpl>
    implements _$$AnaumeImplCopyWith<$Res> {
  __$$AnaumeImplCopyWithImpl(
      _$AnaumeImpl _value, $Res Function(_$AnaumeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? score = null,
    Object? answer = null,
    Object? correct = null,
    Object? reloadFlag = null,
  }) {
    return _then(_$AnaumeImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
      reloadFlag: null == reloadFlag
          ? _value.reloadFlag
          : reloadFlag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AnaumeImpl extends Anaume with DiagnosticableTreeMixin {
  const _$AnaumeImpl(
      {required this.title,
      required this.question,
      required this.correctAnswer,
      required this.score,
      this.answer = "",
      this.correct = false,
      this.reloadFlag = false})
      : super._();

  @override
  final String title;
  @override
  final String question;
  @override
  final String correctAnswer;
  @override
  final int score;
  @override
  @JsonKey()
  final String answer;
  @override
  @JsonKey()
  final bool correct;
  @override
  @JsonKey()
  final bool reloadFlag;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Quiz.anaume(title: $title, question: $question, correctAnswer: $correctAnswer, score: $score, answer: $answer, correct: $correct, reloadFlag: $reloadFlag)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Quiz.anaume'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('correct', correct))
      ..add(DiagnosticsProperty('reloadFlag', reloadFlag));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnaumeImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.reloadFlag, reloadFlag) ||
                other.reloadFlag == reloadFlag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, question, correctAnswer,
      score, answer, correct, reloadFlag);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnaumeImplCopyWith<_$AnaumeImpl> get copyWith =>
      __$$AnaumeImplCopyWithImpl<_$AnaumeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        sentaku,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        anaume,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        kijutsu,
  }) {
    return anaume(
        title, question, correctAnswer, score, answer, correct, reloadFlag);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
  }) {
    return anaume?.call(
        title, question, correctAnswer, score, answer, correct, reloadFlag);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
    required TResult orElse(),
  }) {
    if (anaume != null) {
      return anaume(
          title, question, correctAnswer, score, answer, correct, reloadFlag);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Sentaku value) sentaku,
    required TResult Function(Anaume value) anaume,
    required TResult Function(Kijutsu value) kijutsu,
  }) {
    return anaume(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Sentaku value)? sentaku,
    TResult? Function(Anaume value)? anaume,
    TResult? Function(Kijutsu value)? kijutsu,
  }) {
    return anaume?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Sentaku value)? sentaku,
    TResult Function(Anaume value)? anaume,
    TResult Function(Kijutsu value)? kijutsu,
    required TResult orElse(),
  }) {
    if (anaume != null) {
      return anaume(this);
    }
    return orElse();
  }
}

abstract class Anaume extends Quiz {
  const factory Anaume(
      {required final String title,
      required final String question,
      required final String correctAnswer,
      required final int score,
      final String answer,
      final bool correct,
      final bool reloadFlag}) = _$AnaumeImpl;
  const Anaume._() : super._();

  @override
  String get title;
  @override
  String get question;
  @override
  String get correctAnswer;
  @override
  int get score;
  @override
  String get answer;
  @override
  bool get correct;
  @override
  bool get reloadFlag;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnaumeImplCopyWith<_$AnaumeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$KijutsuImplCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$$KijutsuImplCopyWith(
          _$KijutsuImpl value, $Res Function(_$KijutsuImpl) then) =
      __$$KijutsuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String question,
      String correctAnswer,
      int score,
      String answer,
      bool correct,
      bool reloadFlag});
}

/// @nodoc
class __$$KijutsuImplCopyWithImpl<$Res>
    extends _$QuizCopyWithImpl<$Res, _$KijutsuImpl>
    implements _$$KijutsuImplCopyWith<$Res> {
  __$$KijutsuImplCopyWithImpl(
      _$KijutsuImpl _value, $Res Function(_$KijutsuImpl) _then)
      : super(_value, _then);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? score = null,
    Object? answer = null,
    Object? correct = null,
    Object? reloadFlag = null,
  }) {
    return _then(_$KijutsuImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correct: null == correct
          ? _value.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as bool,
      reloadFlag: null == reloadFlag
          ? _value.reloadFlag
          : reloadFlag // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$KijutsuImpl extends Kijutsu with DiagnosticableTreeMixin {
  const _$KijutsuImpl(
      {required this.title,
      required this.question,
      required this.correctAnswer,
      required this.score,
      this.answer = "",
      this.correct = false,
      this.reloadFlag = false})
      : super._();

  @override
  final String title;
  @override
  final String question;
  @override
  final String correctAnswer;
  @override
  final int score;
  @override
  @JsonKey()
  final String answer;
  @override
  @JsonKey()
  final bool correct;
  @override
  @JsonKey()
  final bool reloadFlag;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Quiz.kijutsu(title: $title, question: $question, correctAnswer: $correctAnswer, score: $score, answer: $answer, correct: $correct, reloadFlag: $reloadFlag)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Quiz.kijutsu'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('correct', correct))
      ..add(DiagnosticsProperty('reloadFlag', reloadFlag));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KijutsuImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.reloadFlag, reloadFlag) ||
                other.reloadFlag == reloadFlag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, question, correctAnswer,
      score, answer, correct, reloadFlag);

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KijutsuImplCopyWith<_$KijutsuImpl> get copyWith =>
      __$$KijutsuImplCopyWithImpl<_$KijutsuImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        sentaku,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        anaume,
    required TResult Function(
            String title,
            String question,
            String correctAnswer,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)
        kijutsu,
  }) {
    return kijutsu(
        title, question, correctAnswer, score, answer, correct, reloadFlag);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult? Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
  }) {
    return kijutsu?.call(
        title, question, correctAnswer, score, answer, correct, reloadFlag);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String question,
            String correctAnswer,
            List<Option> options,
            int score,
            String answer,
            bool correct,
            bool reloadFlag)?
        sentaku,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        anaume,
    TResult Function(String title, String question, String correctAnswer,
            int score, String answer, bool correct, bool reloadFlag)?
        kijutsu,
    required TResult orElse(),
  }) {
    if (kijutsu != null) {
      return kijutsu(
          title, question, correctAnswer, score, answer, correct, reloadFlag);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Sentaku value) sentaku,
    required TResult Function(Anaume value) anaume,
    required TResult Function(Kijutsu value) kijutsu,
  }) {
    return kijutsu(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Sentaku value)? sentaku,
    TResult? Function(Anaume value)? anaume,
    TResult? Function(Kijutsu value)? kijutsu,
  }) {
    return kijutsu?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Sentaku value)? sentaku,
    TResult Function(Anaume value)? anaume,
    TResult Function(Kijutsu value)? kijutsu,
    required TResult orElse(),
  }) {
    if (kijutsu != null) {
      return kijutsu(this);
    }
    return orElse();
  }
}

abstract class Kijutsu extends Quiz {
  const factory Kijutsu(
      {required final String title,
      required final String question,
      required final String correctAnswer,
      required final int score,
      final String answer,
      final bool correct,
      final bool reloadFlag}) = _$KijutsuImpl;
  const Kijutsu._() : super._();

  @override
  String get title;
  @override
  String get question;
  @override
  String get correctAnswer;
  @override
  int get score;
  @override
  String get answer;
  @override
  bool get correct;
  @override
  bool get reloadFlag;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KijutsuImplCopyWith<_$KijutsuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Option {
  int get number => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OptionCopyWith<Option> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OptionCopyWith<$Res> {
  factory $OptionCopyWith(Option value, $Res Function(Option) then) =
      _$OptionCopyWithImpl<$Res, Option>;
  @useResult
  $Res call({int number, String word});
}

/// @nodoc
class _$OptionCopyWithImpl<$Res, $Val extends Option>
    implements $OptionCopyWith<$Res> {
  _$OptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? word = null,
  }) {
    return _then(_value.copyWith(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OptionImplCopyWith<$Res> implements $OptionCopyWith<$Res> {
  factory _$$OptionImplCopyWith(
          _$OptionImpl value, $Res Function(_$OptionImpl) then) =
      __$$OptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int number, String word});
}

/// @nodoc
class __$$OptionImplCopyWithImpl<$Res>
    extends _$OptionCopyWithImpl<$Res, _$OptionImpl>
    implements _$$OptionImplCopyWith<$Res> {
  __$$OptionImplCopyWithImpl(
      _$OptionImpl _value, $Res Function(_$OptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? number = null,
    Object? word = null,
  }) {
    return _then(_$OptionImpl(
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OptionImpl extends _Option with DiagnosticableTreeMixin {
  const _$OptionImpl({required this.number, required this.word}) : super._();

  @override
  final int number;
  @override
  final String word;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Option(number: $number, word: $word)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Option'))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('word', word));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OptionImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.word, word) || other.word == word));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number, word);

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      __$$OptionImplCopyWithImpl<_$OptionImpl>(this, _$identity);
}

abstract class _Option extends Option {
  const factory _Option(
      {required final int number, required final String word}) = _$OptionImpl;
  const _Option._() : super._();

  @override
  int get number;
  @override
  String get word;

  /// Create a copy of Option
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OptionImplCopyWith<_$OptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
