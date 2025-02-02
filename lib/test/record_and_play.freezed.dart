// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record_and_play.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioRecordState {
  bool get isRecording => throw _privateConstructorUsedError;

  /// Create a copy of AudioRecordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioRecordStateCopyWith<AudioRecordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioRecordStateCopyWith<$Res> {
  factory $AudioRecordStateCopyWith(
          AudioRecordState value, $Res Function(AudioRecordState) then) =
      _$AudioRecordStateCopyWithImpl<$Res, AudioRecordState>;
  @useResult
  $Res call({bool isRecording});
}

/// @nodoc
class _$AudioRecordStateCopyWithImpl<$Res, $Val extends AudioRecordState>
    implements $AudioRecordStateCopyWith<$Res> {
  _$AudioRecordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioRecordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
  }) {
    return _then(_value.copyWith(
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioRecordStateImplCopyWith<$Res>
    implements $AudioRecordStateCopyWith<$Res> {
  factory _$$AudioRecordStateImplCopyWith(_$AudioRecordStateImpl value,
          $Res Function(_$AudioRecordStateImpl) then) =
      __$$AudioRecordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isRecording});
}

/// @nodoc
class __$$AudioRecordStateImplCopyWithImpl<$Res>
    extends _$AudioRecordStateCopyWithImpl<$Res, _$AudioRecordStateImpl>
    implements _$$AudioRecordStateImplCopyWith<$Res> {
  __$$AudioRecordStateImplCopyWithImpl(_$AudioRecordStateImpl _value,
      $Res Function(_$AudioRecordStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioRecordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
  }) {
    return _then(_$AudioRecordStateImpl(
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AudioRecordStateImpl
    with DiagnosticableTreeMixin
    implements _AudioRecordState {
  const _$AudioRecordStateImpl({this.isRecording = false});

  @override
  @JsonKey()
  final bool isRecording;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioRecordState(isRecording: $isRecording)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioRecordState'))
      ..add(DiagnosticsProperty('isRecording', isRecording));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioRecordStateImpl &&
            (identical(other.isRecording, isRecording) ||
                other.isRecording == isRecording));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isRecording);

  /// Create a copy of AudioRecordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioRecordStateImplCopyWith<_$AudioRecordStateImpl> get copyWith =>
      __$$AudioRecordStateImplCopyWithImpl<_$AudioRecordStateImpl>(
          this, _$identity);
}

abstract class _AudioRecordState implements AudioRecordState {
  const factory _AudioRecordState({final bool isRecording}) =
      _$AudioRecordStateImpl;

  @override
  bool get isRecording;

  /// Create a copy of AudioRecordState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioRecordStateImplCopyWith<_$AudioRecordStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AudioPlayState {
  bool get isPlaying => throw _privateConstructorUsedError;

  /// Create a copy of AudioPlayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioPlayStateCopyWith<AudioPlayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioPlayStateCopyWith<$Res> {
  factory $AudioPlayStateCopyWith(
          AudioPlayState value, $Res Function(AudioPlayState) then) =
      _$AudioPlayStateCopyWithImpl<$Res, AudioPlayState>;
  @useResult
  $Res call({bool isPlaying});
}

/// @nodoc
class _$AudioPlayStateCopyWithImpl<$Res, $Val extends AudioPlayState>
    implements $AudioPlayStateCopyWith<$Res> {
  _$AudioPlayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioPlayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
  }) {
    return _then(_value.copyWith(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioPlayStateImplCopyWith<$Res>
    implements $AudioPlayStateCopyWith<$Res> {
  factory _$$AudioPlayStateImplCopyWith(_$AudioPlayStateImpl value,
          $Res Function(_$AudioPlayStateImpl) then) =
      __$$AudioPlayStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isPlaying});
}

/// @nodoc
class __$$AudioPlayStateImplCopyWithImpl<$Res>
    extends _$AudioPlayStateCopyWithImpl<$Res, _$AudioPlayStateImpl>
    implements _$$AudioPlayStateImplCopyWith<$Res> {
  __$$AudioPlayStateImplCopyWithImpl(
      _$AudioPlayStateImpl _value, $Res Function(_$AudioPlayStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AudioPlayState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPlaying = null,
  }) {
    return _then(_$AudioPlayStateImpl(
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AudioPlayStateImpl
    with DiagnosticableTreeMixin
    implements _AudioPlayState {
  const _$AudioPlayStateImpl({this.isPlaying = false});

  @override
  @JsonKey()
  final bool isPlaying;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioPlayState(isPlaying: $isPlaying)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioPlayState'))
      ..add(DiagnosticsProperty('isPlaying', isPlaying));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioPlayStateImpl &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isPlaying);

  /// Create a copy of AudioPlayState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioPlayStateImplCopyWith<_$AudioPlayStateImpl> get copyWith =>
      __$$AudioPlayStateImplCopyWithImpl<_$AudioPlayStateImpl>(
          this, _$identity);
}

abstract class _AudioPlayState implements AudioPlayState {
  const factory _AudioPlayState({final bool isPlaying}) = _$AudioPlayStateImpl;

  @override
  bool get isPlaying;

  /// Create a copy of AudioPlayState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioPlayStateImplCopyWith<_$AudioPlayStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
