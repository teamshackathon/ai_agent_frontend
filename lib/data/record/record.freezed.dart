// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StreamRecord {
  AudioRecorder get recorder => throw _privateConstructorUsedError;
  Socket get socket => throw _privateConstructorUsedError;
  bool get isRecording => throw _privateConstructorUsedError;
  double get dB => throw _privateConstructorUsedError;

  /// Create a copy of StreamRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreamRecordCopyWith<StreamRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreamRecordCopyWith<$Res> {
  factory $StreamRecordCopyWith(
          StreamRecord value, $Res Function(StreamRecord) then) =
      _$StreamRecordCopyWithImpl<$Res, StreamRecord>;
  @useResult
  $Res call(
      {AudioRecorder recorder, Socket socket, bool isRecording, double dB});
}

/// @nodoc
class _$StreamRecordCopyWithImpl<$Res, $Val extends StreamRecord>
    implements $StreamRecordCopyWith<$Res> {
  _$StreamRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreamRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recorder = null,
    Object? socket = null,
    Object? isRecording = null,
    Object? dB = null,
  }) {
    return _then(_value.copyWith(
      recorder: null == recorder
          ? _value.recorder
          : recorder // ignore: cast_nullable_to_non_nullable
              as AudioRecorder,
      socket: null == socket
          ? _value.socket
          : socket // ignore: cast_nullable_to_non_nullable
              as Socket,
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      dB: null == dB
          ? _value.dB
          : dB // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreamRecordImplCopyWith<$Res>
    implements $StreamRecordCopyWith<$Res> {
  factory _$$StreamRecordImplCopyWith(
          _$StreamRecordImpl value, $Res Function(_$StreamRecordImpl) then) =
      __$$StreamRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AudioRecorder recorder, Socket socket, bool isRecording, double dB});
}

/// @nodoc
class __$$StreamRecordImplCopyWithImpl<$Res>
    extends _$StreamRecordCopyWithImpl<$Res, _$StreamRecordImpl>
    implements _$$StreamRecordImplCopyWith<$Res> {
  __$$StreamRecordImplCopyWithImpl(
      _$StreamRecordImpl _value, $Res Function(_$StreamRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreamRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recorder = null,
    Object? socket = null,
    Object? isRecording = null,
    Object? dB = null,
  }) {
    return _then(_$StreamRecordImpl(
      recorder: null == recorder
          ? _value.recorder
          : recorder // ignore: cast_nullable_to_non_nullable
              as AudioRecorder,
      socket: null == socket
          ? _value.socket
          : socket // ignore: cast_nullable_to_non_nullable
              as Socket,
      isRecording: null == isRecording
          ? _value.isRecording
          : isRecording // ignore: cast_nullable_to_non_nullable
              as bool,
      dB: null == dB
          ? _value.dB
          : dB // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$StreamRecordImpl implements _StreamRecord {
  const _$StreamRecordImpl(
      {required this.recorder,
      required this.socket,
      this.isRecording = false,
      this.dB = 0.0});

  @override
  final AudioRecorder recorder;
  @override
  final Socket socket;
  @override
  @JsonKey()
  final bool isRecording;
  @override
  @JsonKey()
  final double dB;

  @override
  String toString() {
    return 'StreamRecord(recorder: $recorder, socket: $socket, isRecording: $isRecording, dB: $dB)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreamRecordImpl &&
            (identical(other.recorder, recorder) ||
                other.recorder == recorder) &&
            (identical(other.socket, socket) || other.socket == socket) &&
            (identical(other.isRecording, isRecording) ||
                other.isRecording == isRecording) &&
            (identical(other.dB, dB) || other.dB == dB));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, recorder, socket, isRecording, dB);

  /// Create a copy of StreamRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreamRecordImplCopyWith<_$StreamRecordImpl> get copyWith =>
      __$$StreamRecordImplCopyWithImpl<_$StreamRecordImpl>(this, _$identity);
}

abstract class _StreamRecord implements StreamRecord {
  const factory _StreamRecord(
      {required final AudioRecorder recorder,
      required final Socket socket,
      final bool isRecording,
      final double dB}) = _$StreamRecordImpl;

  @override
  AudioRecorder get recorder;
  @override
  Socket get socket;
  @override
  bool get isRecording;
  @override
  double get dB;

  /// Create a copy of StreamRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreamRecordImplCopyWith<_$StreamRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
