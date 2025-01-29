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

Quiz _$QuizFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'sentaku':
      return Sentaku.fromJson(json);
    case 'anaume':
      return Anaume.fromJson(json);
    case 'kijutsu':
      return Kijutsu.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'Quiz',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$Quiz {
  String get title => throw _privateConstructorUsedError;
  String get format => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError; // int? answerNo,
  bool get correctFlag => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)
        sentaku,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        anaume,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        kijutsu,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
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

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
      String format,
      String question,
      String correctAnswer,
      String answer,
      bool correctFlag,
      String? comment});
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
    Object? format = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? answer = null,
    Object? correctFlag = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer!
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correctFlag: null == correctFlag
          ? _value.correctFlag
          : correctFlag // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String format,
      String question,
      String correctAnswer,
      List<Map<String, Object>> options,
      String answer,
      bool correctFlag,
      String? comment});
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
    Object? format = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? options = null,
    Object? answer = null,
    Object? correctFlag = null,
    Object? comment = freezed,
  }) {
    return _then(_$SentakuImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
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
              as List<Map<String, Object>>,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      correctFlag: null == correctFlag
          ? _value.correctFlag
          : correctFlag // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SentakuImpl extends Sentaku with DiagnosticableTreeMixin {
  const _$SentakuImpl(
      {required this.title,
      required this.format,
      required this.question,
      required this.correctAnswer,
      required final List<Map<String, Object>> options,
      this.answer = "",
      this.correctFlag = false,
      this.comment,
      final String? $type})
      : _options = options,
        $type = $type ?? 'sentaku',
        super._();

  factory _$SentakuImpl.fromJson(Map<String, dynamic> json) =>
      _$$SentakuImplFromJson(json);

  @override
  final String title;
  @override
  final String format;
  @override
  final String question;
  @override
  final String correctAnswer;
  final List<Map<String, Object>> _options;
  @override
  List<Map<String, Object>> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey()
  final String answer;
// int? answerNo,
  @override
  @JsonKey()
  final bool correctFlag;
  @override
  final String? comment;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Quiz.sentaku(title: $title, format: $format, question: $question, correctAnswer: $correctAnswer, options: $options, answer: $answer, correctFlag: $correctFlag, comment: $comment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Quiz.sentaku'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('format', format))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('correctFlag', correctFlag))
      ..add(DiagnosticsProperty('comment', comment));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentakuImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correctFlag, correctFlag) ||
                other.correctFlag == correctFlag) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      format,
      question,
      correctAnswer,
      const DeepCollectionEquality().hash(_options),
      answer,
      correctFlag,
      comment);

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
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)
        sentaku,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        anaume,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        kijutsu,
  }) {
    return sentaku(title, format, question, correctAnswer, options, answer,
        correctFlag, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
  }) {
    return sentaku?.call(title, format, question, correctAnswer, options,
        answer, correctFlag, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
    required TResult orElse(),
  }) {
    if (sentaku != null) {
      return sentaku(title, format, question, correctAnswer, options, answer,
          correctFlag, comment);
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

  @override
  Map<String, dynamic> toJson() {
    return _$$SentakuImplToJson(
      this,
    );
  }
}

abstract class Sentaku extends Quiz {
  const factory Sentaku(
      {required final String title,
      required final String format,
      required final String question,
      required final String correctAnswer,
      required final List<Map<String, Object>> options,
      final String answer,
      final bool correctFlag,
      final String? comment}) = _$SentakuImpl;
  const Sentaku._() : super._();

  factory Sentaku.fromJson(Map<String, dynamic> json) = _$SentakuImpl.fromJson;

  @override
  String get title;
  @override
  String get format;
  @override
  String get question;
  @override
  String get correctAnswer;
  List<Map<String, Object>> get options;
  @override
  String get answer; // int? answerNo,
  @override
  bool get correctFlag;
  @override
  String? get comment;

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
      String format,
      String question,
      String correctAnswer,
      String? answer,
      bool correctFlag,
      String? comment});
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
    Object? format = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? answer = freezed,
    Object? correctFlag = null,
    Object? comment = freezed,
  }) {
    return _then(_$AnaumeImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      correctFlag: null == correctFlag
          ? _value.correctFlag
          : correctFlag // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnaumeImpl extends Anaume with DiagnosticableTreeMixin {
  const _$AnaumeImpl(
      {required this.title,
      required this.format,
      required this.question,
      required this.correctAnswer,
      this.answer,
      this.correctFlag = false,
      this.comment,
      final String? $type})
      : $type = $type ?? 'anaume',
        super._();

  factory _$AnaumeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnaumeImplFromJson(json);

  @override
  final String title;
  @override
  final String format;
  @override
  final String question;
  @override
  final String correctAnswer;
  @override
  final String? answer;
  @override
  @JsonKey()
  final bool correctFlag;
  @override
  final String? comment;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Quiz.anaume(title: $title, format: $format, question: $question, correctAnswer: $correctAnswer, answer: $answer, correctFlag: $correctFlag, comment: $comment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Quiz.anaume'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('format', format))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('correctFlag', correctFlag))
      ..add(DiagnosticsProperty('comment', comment));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnaumeImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correctFlag, correctFlag) ||
                other.correctFlag == correctFlag) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, format, question,
      correctAnswer, answer, correctFlag, comment);

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
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)
        sentaku,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        anaume,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        kijutsu,
  }) {
    return anaume(
        title, format, question, correctAnswer, answer, correctFlag, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
  }) {
    return anaume?.call(
        title, format, question, correctAnswer, answer, correctFlag, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
    required TResult orElse(),
  }) {
    if (anaume != null) {
      return anaume(
          title, format, question, correctAnswer, answer, correctFlag, comment);
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

  @override
  Map<String, dynamic> toJson() {
    return _$$AnaumeImplToJson(
      this,
    );
  }
}

abstract class Anaume extends Quiz {
  const factory Anaume(
      {required final String title,
      required final String format,
      required final String question,
      required final String correctAnswer,
      final String? answer,
      final bool correctFlag,
      final String? comment}) = _$AnaumeImpl;
  const Anaume._() : super._();

  factory Anaume.fromJson(Map<String, dynamic> json) = _$AnaumeImpl.fromJson;

  @override
  String get title;
  @override
  String get format;
  @override
  String get question;
  @override
  String get correctAnswer;
  @override
  String? get answer;
  @override
  bool get correctFlag;
  @override
  String? get comment;

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
      String format,
      String question,
      String correctAnswer,
      String? answer,
      bool correctFlag,
      String? comment});
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
    Object? format = null,
    Object? question = null,
    Object? correctAnswer = null,
    Object? answer = freezed,
    Object? correctFlag = null,
    Object? comment = freezed,
  }) {
    return _then(_$KijutsuImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      correctAnswer: null == correctAnswer
          ? _value.correctAnswer
          : correctAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      correctFlag: null == correctFlag
          ? _value.correctFlag
          : correctFlag // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KijutsuImpl extends Kijutsu with DiagnosticableTreeMixin {
  const _$KijutsuImpl(
      {required this.title,
      required this.format,
      required this.question,
      required this.correctAnswer,
      this.answer,
      this.correctFlag = false,
      this.comment,
      final String? $type})
      : $type = $type ?? 'kijutsu',
        super._();

  factory _$KijutsuImpl.fromJson(Map<String, dynamic> json) =>
      _$$KijutsuImplFromJson(json);

  @override
  final String title;
  @override
  final String format;
  @override
  final String question;
  @override
  final String correctAnswer;
  @override
  final String? answer;
  @override
  @JsonKey()
  final bool correctFlag;
  @override
  final String? comment;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Quiz.kijutsu(title: $title, format: $format, question: $question, correctAnswer: $correctAnswer, answer: $answer, correctFlag: $correctFlag, comment: $comment)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Quiz.kijutsu'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('format', format))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('correctFlag', correctFlag))
      ..add(DiagnosticsProperty('comment', comment));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KijutsuImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.correctFlag, correctFlag) ||
                other.correctFlag == correctFlag) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, format, question,
      correctAnswer, answer, correctFlag, comment);

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
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)
        sentaku,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        anaume,
    required TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)
        kijutsu,
  }) {
    return kijutsu(
        title, format, question, correctAnswer, answer, correctFlag, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult? Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
  }) {
    return kijutsu?.call(
        title, format, question, correctAnswer, answer, correctFlag, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            List<Map<String, Object>> options,
            String answer,
            bool correctFlag,
            String? comment)?
        sentaku,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        anaume,
    TResult Function(
            String title,
            String format,
            String question,
            String correctAnswer,
            String? answer,
            bool correctFlag,
            String? comment)?
        kijutsu,
    required TResult orElse(),
  }) {
    if (kijutsu != null) {
      return kijutsu(
          title, format, question, correctAnswer, answer, correctFlag, comment);
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

  @override
  Map<String, dynamic> toJson() {
    return _$$KijutsuImplToJson(
      this,
    );
  }
}

abstract class Kijutsu extends Quiz {
  const factory Kijutsu(
      {required final String title,
      required final String format,
      required final String question,
      required final String correctAnswer,
      final String? answer,
      final bool correctFlag,
      final String? comment}) = _$KijutsuImpl;
  const Kijutsu._() : super._();

  factory Kijutsu.fromJson(Map<String, dynamic> json) = _$KijutsuImpl.fromJson;

  @override
  String get title;
  @override
  String get format;
  @override
  String get question;
  @override
  String get correctAnswer;
  @override
  String? get answer;
  @override
  bool get correctFlag;
  @override
  String? get comment;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KijutsuImplCopyWith<_$KijutsuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
