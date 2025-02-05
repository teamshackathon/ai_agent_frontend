// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeRoomsHash() => r'749af0c8bfbd38e3764db76012422f2e8d686b87';

/// @nodoc
mixin _$Room {
  String get year => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get chatId =>
      throw _privateConstructorUsedError; // 各授業のlessonsまでのpathを保持しておく
  CollectionReference<Object?> get reference =>
      throw _privateConstructorUsedError; // 各授業の個人のlessonsまでのpathを保持しておく
  CollectionReference<Object?> get ownReference =>
      throw _privateConstructorUsedError;
  String get teacher => throw _privateConstructorUsedError; // データ名にしとくと、後から楽そう
  String get textDataName => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {String year,
      String roomNumber,
      String subject,
      String chatId,
      CollectionReference<Object?> reference,
      CollectionReference<Object?> ownReference,
      String teacher,
      String textDataName});
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? roomNumber = null,
    Object? subject = null,
    Object? chatId = null,
    Object? reference = null,
    Object? ownReference = null,
    Object? teacher = null,
    Object? textDataName = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as CollectionReference<Object?>,
      ownReference: null == ownReference
          ? _value.ownReference
          : ownReference // ignore: cast_nullable_to_non_nullable
              as CollectionReference<Object?>,
      teacher: null == teacher
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      textDataName: null == textDataName
          ? _value.textDataName
          : textDataName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
          _$RoomImpl value, $Res Function(_$RoomImpl) then) =
      __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String year,
      String roomNumber,
      String subject,
      String chatId,
      CollectionReference<Object?> reference,
      CollectionReference<Object?> ownReference,
      String teacher,
      String textDataName});
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? roomNumber = null,
    Object? subject = null,
    Object? chatId = null,
    Object? reference = null,
    Object? ownReference = null,
    Object? teacher = null,
    Object? textDataName = null,
  }) {
    return _then(_$RoomImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as CollectionReference<Object?>,
      ownReference: null == ownReference
          ? _value.ownReference
          : ownReference // ignore: cast_nullable_to_non_nullable
              as CollectionReference<Object?>,
      teacher: null == teacher
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      textDataName: null == textDataName
          ? _value.textDataName
          : textDataName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RoomImpl extends _Room {
  const _$RoomImpl(
      {required this.year,
      required this.roomNumber,
      required this.subject,
      required this.chatId,
      required this.reference,
      required this.ownReference,
      required this.teacher,
      required this.textDataName})
      : super._();

  @override
  final String year;
  @override
  final String roomNumber;
  @override
  final String subject;
  @override
  final String chatId;
// 各授業のlessonsまでのpathを保持しておく
  @override
  final CollectionReference<Object?> reference;
// 各授業の個人のlessonsまでのpathを保持しておく
  @override
  final CollectionReference<Object?> ownReference;
  @override
  final String teacher;
// データ名にしとくと、後から楽そう
  @override
  final String textDataName;

  @override
  String toString() {
    return 'Room(year: $year, roomNumber: $roomNumber, subject: $subject, chatId: $chatId, reference: $reference, ownReference: $ownReference, teacher: $teacher, textDataName: $textDataName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.ownReference, ownReference) ||
                other.ownReference == ownReference) &&
            (identical(other.teacher, teacher) || other.teacher == teacher) &&
            (identical(other.textDataName, textDataName) ||
                other.textDataName == textDataName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, year, roomNumber, subject,
      chatId, reference, ownReference, teacher, textDataName);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);
}

abstract class _Room extends Room {
  const factory _Room(
      {required final String year,
      required final String roomNumber,
      required final String subject,
      required final String chatId,
      required final CollectionReference<Object?> reference,
      required final CollectionReference<Object?> ownReference,
      required final String teacher,
      required final String textDataName}) = _$RoomImpl;
  const _Room._() : super._();

  @override
  String get year;
  @override
  String get roomNumber;
  @override
  String get subject;
  @override
  String get chatId; // 各授業のlessonsまでのpathを保持しておく
  @override
  CollectionReference<Object?> get reference; // 各授業の個人のlessonsまでのpathを保持しておく
  @override
  CollectionReference<Object?> get ownReference;
  @override
  String get teacher; // データ名にしとくと、後から楽そう
  @override
  String get textDataName;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
