// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Agenda {
  String get title => throw _privateConstructorUsedError;
  List<Sentence> get sentences => throw _privateConstructorUsedError;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AgendaCopyWith<Agenda> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgendaCopyWith<$Res> {
  factory $AgendaCopyWith(Agenda value, $Res Function(Agenda) then) =
      _$AgendaCopyWithImpl<$Res, Agenda>;
  @useResult
  $Res call({String title, List<Sentence> sentences});
}

/// @nodoc
class _$AgendaCopyWithImpl<$Res, $Val extends Agenda>
    implements $AgendaCopyWith<$Res> {
  _$AgendaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? sentences = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sentences: null == sentences
          ? _value.sentences
          : sentences // ignore: cast_nullable_to_non_nullable
              as List<Sentence>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgendaImplCopyWith<$Res> implements $AgendaCopyWith<$Res> {
  factory _$$AgendaImplCopyWith(
          _$AgendaImpl value, $Res Function(_$AgendaImpl) then) =
      __$$AgendaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, List<Sentence> sentences});
}

/// @nodoc
class __$$AgendaImplCopyWithImpl<$Res>
    extends _$AgendaCopyWithImpl<$Res, _$AgendaImpl>
    implements _$$AgendaImplCopyWith<$Res> {
  __$$AgendaImplCopyWithImpl(
      _$AgendaImpl _value, $Res Function(_$AgendaImpl) _then)
      : super(_value, _then);

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? sentences = null,
  }) {
    return _then(_$AgendaImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sentences: null == sentences
          ? _value._sentences
          : sentences // ignore: cast_nullable_to_non_nullable
              as List<Sentence>,
    ));
  }
}

/// @nodoc

class _$AgendaImpl extends _Agenda {
  const _$AgendaImpl(
      {required this.title, required final List<Sentence> sentences})
      : _sentences = sentences,
        super._();

  @override
  final String title;
  final List<Sentence> _sentences;
  @override
  List<Sentence> get sentences {
    if (_sentences is EqualUnmodifiableListView) return _sentences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sentences);
  }

  @override
  String toString() {
    return 'Agenda(title: $title, sentences: $sentences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgendaImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._sentences, _sentences));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, title, const DeepCollectionEquality().hash(_sentences));

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      __$$AgendaImplCopyWithImpl<_$AgendaImpl>(this, _$identity);
}

abstract class _Agenda extends Agenda {
  const factory _Agenda(
      {required final String title,
      required final List<Sentence> sentences}) = _$AgendaImpl;
  const _Agenda._() : super._();

  @override
  String get title;
  @override
  List<Sentence> get sentences;

  /// Create a copy of Agenda
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AgendaImplCopyWith<_$AgendaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Sentence {
  String get subtitle => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Create a copy of Sentence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SentenceCopyWith<Sentence> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SentenceCopyWith<$Res> {
  factory $SentenceCopyWith(Sentence value, $Res Function(Sentence) then) =
      _$SentenceCopyWithImpl<$Res, Sentence>;
  @useResult
  $Res call({String subtitle, int time, String description});
}

/// @nodoc
class _$SentenceCopyWithImpl<$Res, $Val extends Sentence>
    implements $SentenceCopyWith<$Res> {
  _$SentenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Sentence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitle = null,
    Object? time = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SentenceImplCopyWith<$Res>
    implements $SentenceCopyWith<$Res> {
  factory _$$SentenceImplCopyWith(
          _$SentenceImpl value, $Res Function(_$SentenceImpl) then) =
      __$$SentenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String subtitle, int time, String description});
}

/// @nodoc
class __$$SentenceImplCopyWithImpl<$Res>
    extends _$SentenceCopyWithImpl<$Res, _$SentenceImpl>
    implements _$$SentenceImplCopyWith<$Res> {
  __$$SentenceImplCopyWithImpl(
      _$SentenceImpl _value, $Res Function(_$SentenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Sentence
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subtitle = null,
    Object? time = null,
    Object? description = null,
  }) {
    return _then(_$SentenceImpl(
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SentenceImpl extends _Sentence {
  const _$SentenceImpl(
      {required this.subtitle, required this.time, required this.description})
      : super._();

  @override
  final String subtitle;
  @override
  final int time;
  @override
  final String description;

  @override
  String toString() {
    return 'Sentence(subtitle: $subtitle, time: $time, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentenceImpl &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, subtitle, time, description);

  /// Create a copy of Sentence
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentenceImplCopyWith<_$SentenceImpl> get copyWith =>
      __$$SentenceImplCopyWithImpl<_$SentenceImpl>(this, _$identity);
}

abstract class _Sentence extends Sentence {
  const factory _Sentence(
      {required final String subtitle,
      required final int time,
      required final String description}) = _$SentenceImpl;
  const _Sentence._() : super._();

  @override
  String get subtitle;
  @override
  int get time;
  @override
  String get description;

  /// Create a copy of Sentence
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentenceImplCopyWith<_$SentenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
