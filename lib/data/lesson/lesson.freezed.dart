// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Lesson {
  int get count => throw _privateConstructorUsedError;
  Agenda get agendaPublish => throw _privateConstructorUsedError;
  Agenda get agendaDraft => throw _privateConstructorUsedError;
  List<Quiz> get questionsPublish => throw _privateConstructorUsedError;
  List<Quiz> get questionsDraft => throw _privateConstructorUsedError;
  DocumentReference<Object?> get reference =>
      throw _privateConstructorUsedError;
  int get startPage => throw _privateConstructorUsedError;
  int get endPage =>
      throw _privateConstructorUsedError; // before, lesson, break, test, afterの５状態
  String get state => throw _privateConstructorUsedError;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonCopyWith<Lesson> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res, Lesson>;
  @useResult
  $Res call(
      {int count,
      Agenda agendaPublish,
      Agenda agendaDraft,
      List<Quiz> questionsPublish,
      List<Quiz> questionsDraft,
      DocumentReference<Object?> reference,
      int startPage,
      int endPage,
      String state});

  $AgendaCopyWith<$Res> get agendaPublish;
  $AgendaCopyWith<$Res> get agendaDraft;
}

/// @nodoc
class _$LessonCopyWithImpl<$Res, $Val extends Lesson>
    implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? agendaPublish = null,
    Object? agendaDraft = null,
    Object? questionsPublish = null,
    Object? questionsDraft = null,
    Object? reference = null,
    Object? startPage = null,
    Object? endPage = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      agendaPublish: null == agendaPublish
          ? _value.agendaPublish
          : agendaPublish // ignore: cast_nullable_to_non_nullable
              as Agenda,
      agendaDraft: null == agendaDraft
          ? _value.agendaDraft
          : agendaDraft // ignore: cast_nullable_to_non_nullable
              as Agenda,
      questionsPublish: null == questionsPublish
          ? _value.questionsPublish
          : questionsPublish // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
      questionsDraft: null == questionsDraft
          ? _value.questionsDraft
          : questionsDraft // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
      startPage: null == startPage
          ? _value.startPage
          : startPage // ignore: cast_nullable_to_non_nullable
              as int,
      endPage: null == endPage
          ? _value.endPage
          : endPage // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AgendaCopyWith<$Res> get agendaPublish {
    return $AgendaCopyWith<$Res>(_value.agendaPublish, (value) {
      return _then(_value.copyWith(agendaPublish: value) as $Val);
    });
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AgendaCopyWith<$Res> get agendaDraft {
    return $AgendaCopyWith<$Res>(_value.agendaDraft, (value) {
      return _then(_value.copyWith(agendaDraft: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LessonImplCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$$LessonImplCopyWith(
          _$LessonImpl value, $Res Function(_$LessonImpl) then) =
      __$$LessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int count,
      Agenda agendaPublish,
      Agenda agendaDraft,
      List<Quiz> questionsPublish,
      List<Quiz> questionsDraft,
      DocumentReference<Object?> reference,
      int startPage,
      int endPage,
      String state});

  @override
  $AgendaCopyWith<$Res> get agendaPublish;
  @override
  $AgendaCopyWith<$Res> get agendaDraft;
}

/// @nodoc
class __$$LessonImplCopyWithImpl<$Res>
    extends _$LessonCopyWithImpl<$Res, _$LessonImpl>
    implements _$$LessonImplCopyWith<$Res> {
  __$$LessonImplCopyWithImpl(
      _$LessonImpl _value, $Res Function(_$LessonImpl) _then)
      : super(_value, _then);

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? agendaPublish = null,
    Object? agendaDraft = null,
    Object? questionsPublish = null,
    Object? questionsDraft = null,
    Object? reference = null,
    Object? startPage = null,
    Object? endPage = null,
    Object? state = null,
  }) {
    return _then(_$LessonImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      agendaPublish: null == agendaPublish
          ? _value.agendaPublish
          : agendaPublish // ignore: cast_nullable_to_non_nullable
              as Agenda,
      agendaDraft: null == agendaDraft
          ? _value.agendaDraft
          : agendaDraft // ignore: cast_nullable_to_non_nullable
              as Agenda,
      questionsPublish: null == questionsPublish
          ? _value._questionsPublish
          : questionsPublish // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
      questionsDraft: null == questionsDraft
          ? _value._questionsDraft
          : questionsDraft // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
      startPage: null == startPage
          ? _value.startPage
          : startPage // ignore: cast_nullable_to_non_nullable
              as int,
      endPage: null == endPage
          ? _value.endPage
          : endPage // ignore: cast_nullable_to_non_nullable
              as int,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LessonImpl extends _Lesson {
  const _$LessonImpl(
      {required this.count,
      required this.agendaPublish,
      required this.agendaDraft,
      required final List<Quiz> questionsPublish,
      required final List<Quiz> questionsDraft,
      required this.reference,
      required this.startPage,
      required this.endPage,
      required this.state})
      : _questionsPublish = questionsPublish,
        _questionsDraft = questionsDraft,
        super._();

  @override
  final int count;
  @override
  final Agenda agendaPublish;
  @override
  final Agenda agendaDraft;
  final List<Quiz> _questionsPublish;
  @override
  List<Quiz> get questionsPublish {
    if (_questionsPublish is EqualUnmodifiableListView)
      return _questionsPublish;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionsPublish);
  }

  final List<Quiz> _questionsDraft;
  @override
  List<Quiz> get questionsDraft {
    if (_questionsDraft is EqualUnmodifiableListView) return _questionsDraft;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionsDraft);
  }

  @override
  final DocumentReference<Object?> reference;
  @override
  final int startPage;
  @override
  final int endPage;
// before, lesson, break, test, afterの５状態
  @override
  final String state;

  @override
  String toString() {
    return 'Lesson(count: $count, agendaPublish: $agendaPublish, agendaDraft: $agendaDraft, questionsPublish: $questionsPublish, questionsDraft: $questionsDraft, reference: $reference, startPage: $startPage, endPage: $endPage, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.agendaPublish, agendaPublish) ||
                other.agendaPublish == agendaPublish) &&
            (identical(other.agendaDraft, agendaDraft) ||
                other.agendaDraft == agendaDraft) &&
            const DeepCollectionEquality()
                .equals(other._questionsPublish, _questionsPublish) &&
            const DeepCollectionEquality()
                .equals(other._questionsDraft, _questionsDraft) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.startPage, startPage) ||
                other.startPage == startPage) &&
            (identical(other.endPage, endPage) || other.endPage == endPage) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      count,
      agendaPublish,
      agendaDraft,
      const DeepCollectionEquality().hash(_questionsPublish),
      const DeepCollectionEquality().hash(_questionsDraft),
      reference,
      startPage,
      endPage,
      state);

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      __$$LessonImplCopyWithImpl<_$LessonImpl>(this, _$identity);
}

abstract class _Lesson extends Lesson {
  const factory _Lesson(
      {required final int count,
      required final Agenda agendaPublish,
      required final Agenda agendaDraft,
      required final List<Quiz> questionsPublish,
      required final List<Quiz> questionsDraft,
      required final DocumentReference<Object?> reference,
      required final int startPage,
      required final int endPage,
      required final String state}) = _$LessonImpl;
  const _Lesson._() : super._();

  @override
  int get count;
  @override
  Agenda get agendaPublish;
  @override
  Agenda get agendaDraft;
  @override
  List<Quiz> get questionsPublish;
  @override
  List<Quiz> get questionsDraft;
  @override
  DocumentReference<Object?> get reference;
  @override
  int get startPage;
  @override
  int get endPage; // before, lesson, break, test, afterの５状態
  @override
  String get state;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
