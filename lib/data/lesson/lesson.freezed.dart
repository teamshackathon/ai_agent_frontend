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
  Agenda get publishAgenda => throw _privateConstructorUsedError;
  Agenda get draftAgenda => throw _privateConstructorUsedError;
  DocumentReference<Object?> get reference =>
      throw _privateConstructorUsedError;

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
      Agenda publishAgenda,
      Agenda draftAgenda,
      DocumentReference<Object?> reference});

  $AgendaCopyWith<$Res> get publishAgenda;
  $AgendaCopyWith<$Res> get draftAgenda;
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
    Object? publishAgenda = null,
    Object? draftAgenda = null,
    Object? reference = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      publishAgenda: null == publishAgenda
          ? _value.publishAgenda
          : publishAgenda // ignore: cast_nullable_to_non_nullable
              as Agenda,
      draftAgenda: null == draftAgenda
          ? _value.draftAgenda
          : draftAgenda // ignore: cast_nullable_to_non_nullable
              as Agenda,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
    ) as $Val);
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AgendaCopyWith<$Res> get publishAgenda {
    return $AgendaCopyWith<$Res>(_value.publishAgenda, (value) {
      return _then(_value.copyWith(publishAgenda: value) as $Val);
    });
  }

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AgendaCopyWith<$Res> get draftAgenda {
    return $AgendaCopyWith<$Res>(_value.draftAgenda, (value) {
      return _then(_value.copyWith(draftAgenda: value) as $Val);
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
      Agenda publishAgenda,
      Agenda draftAgenda,
      DocumentReference<Object?> reference});

  @override
  $AgendaCopyWith<$Res> get publishAgenda;
  @override
  $AgendaCopyWith<$Res> get draftAgenda;
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
    Object? publishAgenda = null,
    Object? draftAgenda = null,
    Object? reference = null,
  }) {
    return _then(_$LessonImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      publishAgenda: null == publishAgenda
          ? _value.publishAgenda
          : publishAgenda // ignore: cast_nullable_to_non_nullable
              as Agenda,
      draftAgenda: null == draftAgenda
          ? _value.draftAgenda
          : draftAgenda // ignore: cast_nullable_to_non_nullable
              as Agenda,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
    ));
  }
}

/// @nodoc

class _$LessonImpl extends _Lesson {
  const _$LessonImpl(
      {required this.count,
      required this.publishAgenda,
      required this.draftAgenda,
      required this.reference})
      : super._();

  @override
  final int count;
  @override
  final Agenda publishAgenda;
  @override
  final Agenda draftAgenda;
  @override
  final DocumentReference<Object?> reference;

  @override
  String toString() {
    return 'Lesson(count: $count, publishAgenda: $publishAgenda, draftAgenda: $draftAgenda, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.publishAgenda, publishAgenda) ||
                other.publishAgenda == publishAgenda) &&
            (identical(other.draftAgenda, draftAgenda) ||
                other.draftAgenda == draftAgenda) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, count, publishAgenda, draftAgenda, reference);

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
      required final Agenda publishAgenda,
      required final Agenda draftAgenda,
      required final DocumentReference<Object?> reference}) = _$LessonImpl;
  const _Lesson._() : super._();

  @override
  int get count;
  @override
  Agenda get publishAgenda;
  @override
  Agenda get draftAgenda;
  @override
  DocumentReference<Object?> get reference;

  /// Create a copy of Lesson
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonImplCopyWith<_$LessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
