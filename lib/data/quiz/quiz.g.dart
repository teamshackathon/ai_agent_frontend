// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SentakuImpl _$$SentakuImplFromJson(Map<String, dynamic> json) =>
    _$SentakuImpl(
      title: json['title'] as String,
      format: json['format'] as String,
      question: json['question'] as String,
      correctAnswer: json['correctAnswer'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      score: (json['score'] as num).toInt(),
      answer: json['answer'] as String? ?? "",
      correct: json['correct'] as bool? ?? false,
      reloadFlag: json['reloadFlag'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SentakuImplToJson(_$SentakuImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'format': instance.format,
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'options': instance.options,
      'score': instance.score,
      'answer': instance.answer,
      'correct': instance.correct,
      'reloadFlag': instance.reloadFlag,
      'runtimeType': instance.$type,
    };

_$AnaumeImpl _$$AnaumeImplFromJson(Map<String, dynamic> json) => _$AnaumeImpl(
      title: json['title'] as String,
      format: json['format'] as String,
      question: json['question'] as String,
      correctAnswer: json['correctAnswer'] as String,
      score: (json['score'] as num).toInt(),
      answer: json['answer'] as String? ?? "",
      correctF: json['correctF'] as bool? ?? false,
      reloadFlag: json['reloadFlag'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$AnaumeImplToJson(_$AnaumeImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'format': instance.format,
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'score': instance.score,
      'answer': instance.answer,
      'correctF': instance.correctF,
      'reloadFlag': instance.reloadFlag,
      'runtimeType': instance.$type,
    };

_$KijutsuImpl _$$KijutsuImplFromJson(Map<String, dynamic> json) =>
    _$KijutsuImpl(
      title: json['title'] as String,
      format: json['format'] as String,
      question: json['question'] as String,
      correctAnswer: json['correctAnswer'] as String,
      score: (json['score'] as num).toInt(),
      answer: json['answer'] as String? ?? "",
      correct: json['correct'] as bool? ?? false,
      reloadFlag: json['reloadFlag'] as bool? ?? false,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$KijutsuImplToJson(_$KijutsuImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'format': instance.format,
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'score': instance.score,
      'answer': instance.answer,
      'correct': instance.correct,
      'reloadFlag': instance.reloadFlag,
      'runtimeType': instance.$type,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizNotiferHash() => r'df6af1c2c3e99b05b97d03773dc28cd65681484a';

/// See also [QuizNotifer].
@ProviderFor(QuizNotifer)
final quizNotiferProvider = NotifierProvider<QuizNotifer, List<Quiz>>.internal(
  QuizNotifer.new,
  name: r'quizNotiferProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizNotiferHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QuizNotifer = Notifier<List<Quiz>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
