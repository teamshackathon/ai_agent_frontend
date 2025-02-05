// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Room {
  String get year => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get chatId =>
      throw _privateConstructorUsedError; // 各授業のlessonsまでのpathを保持しておく
  CollectionReference<Object?> get reference =>
      throw _privateConstructorUsedError; // 各授業の個人のlessonsまでのpathを保持しておく
  List<String> get students => throw _privateConstructorUsedError;
  String get teacher => throw _privateConstructorUsedError; // データ名にしとくと、後から楽そう
  String get textDataName => throw _privateConstructorUsedError;
  String get teachingHours => throw _privateConstructorUsedError;
  String get numberOfTeachingHours => throw _privateConstructorUsedError;
  String get dateOfLessons => throw _privateConstructorUsedError;
  String get classrooms => throw _privateConstructorUsedError;

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
      List<String> students,
      String teacher,
      String textDataName,
      String teachingHours,
      String numberOfTeachingHours,
      String dateOfLessons,
      String classrooms});
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
    Object? students = null,
    Object? teacher = null,
    Object? textDataName = null,
    Object? teachingHours = null,
    Object? numberOfTeachingHours = null,
    Object? dateOfLessons = null,
    Object? classrooms = null,
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
      students: null == students
          ? _value.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teacher: null == teacher
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      textDataName: null == textDataName
          ? _value.textDataName
          : textDataName // ignore: cast_nullable_to_non_nullable
              as String,
      teachingHours: null == teachingHours
          ? _value.teachingHours
          : teachingHours // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfTeachingHours: null == numberOfTeachingHours
          ? _value.numberOfTeachingHours
          : numberOfTeachingHours // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfLessons: null == dateOfLessons
          ? _value.dateOfLessons
          : dateOfLessons // ignore: cast_nullable_to_non_nullable
              as String,
      classrooms: null == classrooms
          ? _value.classrooms
          : classrooms // ignore: cast_nullable_to_non_nullable
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
      List<String> students,
      String teacher,
      String textDataName,
      String teachingHours,
      String numberOfTeachingHours,
      String dateOfLessons,
      String classrooms});
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
    Object? students = null,
    Object? teacher = null,
    Object? textDataName = null,
    Object? teachingHours = null,
    Object? numberOfTeachingHours = null,
    Object? dateOfLessons = null,
    Object? classrooms = null,
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
      students: null == students
          ? _value._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<String>,
      teacher: null == teacher
          ? _value.teacher
          : teacher // ignore: cast_nullable_to_non_nullable
              as String,
      textDataName: null == textDataName
          ? _value.textDataName
          : textDataName // ignore: cast_nullable_to_non_nullable
              as String,
      teachingHours: null == teachingHours
          ? _value.teachingHours
          : teachingHours // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfTeachingHours: null == numberOfTeachingHours
          ? _value.numberOfTeachingHours
          : numberOfTeachingHours // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfLessons: null == dateOfLessons
          ? _value.dateOfLessons
          : dateOfLessons // ignore: cast_nullable_to_non_nullable
              as String,
      classrooms: null == classrooms
          ? _value.classrooms
          : classrooms // ignore: cast_nullable_to_non_nullable
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
      required final List<String> students,
      required this.teacher,
      required this.textDataName,
      required this.teachingHours,
      required this.numberOfTeachingHours,
      required this.dateOfLessons,
      required this.classrooms})
      : _students = students,
        super._();

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
  final List<String> _students;
// 各授業の個人のlessonsまでのpathを保持しておく
  @override
  List<String> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  @override
  final String teacher;
// データ名にしとくと、後から楽そう
  @override
  final String textDataName;
  @override
  final String teachingHours;
  @override
  final String numberOfTeachingHours;
  @override
  final String dateOfLessons;
  @override
  final String classrooms;

  @override
  String toString() {
    return 'Room(year: $year, roomNumber: $roomNumber, subject: $subject, chatId: $chatId, reference: $reference, students: $students, teacher: $teacher, textDataName: $textDataName, teachingHours: $teachingHours, numberOfTeachingHours: $numberOfTeachingHours, dateOfLessons: $dateOfLessons, classrooms: $classrooms)';
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
            const DeepCollectionEquality().equals(other._students, _students) &&
            (identical(other.teacher, teacher) || other.teacher == teacher) &&
            (identical(other.textDataName, textDataName) ||
                other.textDataName == textDataName) &&
            (identical(other.teachingHours, teachingHours) ||
                other.teachingHours == teachingHours) &&
            (identical(other.numberOfTeachingHours, numberOfTeachingHours) ||
                other.numberOfTeachingHours == numberOfTeachingHours) &&
            (identical(other.dateOfLessons, dateOfLessons) ||
                other.dateOfLessons == dateOfLessons) &&
            (identical(other.classrooms, classrooms) ||
                other.classrooms == classrooms));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      year,
      roomNumber,
      subject,
      chatId,
      reference,
      const DeepCollectionEquality().hash(_students),
      teacher,
      textDataName,
      teachingHours,
      numberOfTeachingHours,
      dateOfLessons,
      classrooms);

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
      required final List<String> students,
      required final String teacher,
      required final String textDataName,
      required final String teachingHours,
      required final String numberOfTeachingHours,
      required final String dateOfLessons,
      required final String classrooms}) = _$RoomImpl;
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
  List<String> get students;
  @override
  String get teacher; // データ名にしとくと、後から楽そう
  @override
  String get textDataName;
  @override
  String get teachingHours;
  @override
  String get numberOfTeachingHours;
  @override
  String get dateOfLessons;
  @override
  String get classrooms;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
