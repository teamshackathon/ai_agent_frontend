// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Person {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get familyName =>
      throw _privateConstructorUsedError; // indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  List<Map<String, String>> get rooms => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        $default, {
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        student,
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        teacher,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Person value) $default, {
    required TResult Function(Student value) student,
    required TResult Function(Teacher value) teacher,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Person value)? $default, {
    TResult? Function(Student value)? student,
    TResult? Function(Teacher value)? teacher,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Person value)? $default, {
    TResult Function(Student value)? student,
    TResult Function(Teacher value)? teacher,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PersonCopyWith<Person> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonCopyWith<$Res> {
  factory $PersonCopyWith(Person value, $Res Function(Person) then) =
      _$PersonCopyWithImpl<$Res, Person>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String firstName,
      String familyName,
      List<Map<String, String>> rooms});
}

/// @nodoc
class _$PersonCopyWithImpl<$Res, $Val extends Person>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? firstName = null,
    Object? familyName = null,
    Object? rooms = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      familyName: null == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String,
      rooms: null == rooms
          ? _value.rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonImplCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$$PersonImplCopyWith(
          _$PersonImpl value, $Res Function(_$PersonImpl) then) =
      __$$PersonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String firstName,
      String familyName,
      List<Map<String, String>> rooms});
}

/// @nodoc
class __$$PersonImplCopyWithImpl<$Res>
    extends _$PersonCopyWithImpl<$Res, _$PersonImpl>
    implements _$$PersonImplCopyWith<$Res> {
  __$$PersonImplCopyWithImpl(
      _$PersonImpl _value, $Res Function(_$PersonImpl) _then)
      : super(_value, _then);

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? firstName = null,
    Object? familyName = null,
    Object? rooms = null,
  }) {
    return _then(_$PersonImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      familyName: null == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String,
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ));
  }
}

/// @nodoc

class _$PersonImpl extends _Person {
  const _$PersonImpl(
      {required this.uid,
      required this.name,
      required this.firstName,
      required this.familyName,
      required final List<Map<String, String>> rooms})
      : _rooms = rooms,
        super._();

  @override
  final String uid;
  @override
  final String name;
  @override
  final String firstName;
  @override
  final String familyName;
// indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  final List<Map<String, String>> _rooms;
// indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  @override
  List<Map<String, String>> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'Person(uid: $uid, name: $name, firstName: $firstName, familyName: $familyName, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, name, firstName, familyName,
      const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonImplCopyWith<_$PersonImpl> get copyWith =>
      __$$PersonImplCopyWithImpl<_$PersonImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        $default, {
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        student,
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        teacher,
  }) {
    return $default(uid, name, firstName, familyName, rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
  }) {
    return $default?.call(uid, name, firstName, familyName, rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(uid, name, firstName, familyName, rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Person value) $default, {
    required TResult Function(Student value) student,
    required TResult Function(Teacher value) teacher,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Person value)? $default, {
    TResult? Function(Student value)? student,
    TResult? Function(Teacher value)? teacher,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Person value)? $default, {
    TResult Function(Student value)? student,
    TResult Function(Teacher value)? teacher,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Person extends Person {
  const factory _Person(
      {required final String uid,
      required final String name,
      required final String firstName,
      required final String familyName,
      required final List<Map<String, String>> rooms}) = _$PersonImpl;
  const _Person._() : super._();

  @override
  String get uid;
  @override
  String get name;
  @override
  String get firstName;
  @override
  String get familyName; // indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  @override
  List<Map<String, String>> get rooms;

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonImplCopyWith<_$PersonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
          _$StudentImpl value, $Res Function(_$StudentImpl) then) =
      __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String firstName,
      String familyName,
      List<Map<String, String>> rooms});
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$PersonCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
      _$StudentImpl _value, $Res Function(_$StudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? firstName = null,
    Object? familyName = null,
    Object? rooms = null,
  }) {
    return _then(_$StudentImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      familyName: null == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String,
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ));
  }
}

/// @nodoc

class _$StudentImpl extends Student {
  const _$StudentImpl(
      {required this.uid,
      required this.name,
      required this.firstName,
      required this.familyName,
      required final List<Map<String, String>> rooms})
      : _rooms = rooms,
        super._();

  @override
  final String uid;
  @override
  final String name;
  @override
  final String firstName;
  @override
  final String familyName;
// indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  final List<Map<String, String>> _rooms;
// indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  @override
  List<Map<String, String>> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'Person.student(uid: $uid, name: $name, firstName: $firstName, familyName: $familyName, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, name, firstName, familyName,
      const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        $default, {
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        student,
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        teacher,
  }) {
    return student(uid, name, firstName, familyName, rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
  }) {
    return student?.call(uid, name, firstName, familyName, rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
    required TResult orElse(),
  }) {
    if (student != null) {
      return student(uid, name, firstName, familyName, rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Person value) $default, {
    required TResult Function(Student value) student,
    required TResult Function(Teacher value) teacher,
  }) {
    return student(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Person value)? $default, {
    TResult? Function(Student value)? student,
    TResult? Function(Teacher value)? teacher,
  }) {
    return student?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Person value)? $default, {
    TResult Function(Student value)? student,
    TResult Function(Teacher value)? teacher,
    required TResult orElse(),
  }) {
    if (student != null) {
      return student(this);
    }
    return orElse();
  }
}

abstract class Student extends Person {
  const factory Student(
      {required final String uid,
      required final String name,
      required final String firstName,
      required final String familyName,
      required final List<Map<String, String>> rooms}) = _$StudentImpl;
  const Student._() : super._();

  @override
  String get uid;
  @override
  String get name;
  @override
  String get firstName;
  @override
  String get familyName; // indexの低い方に最新のクラスが来る
  /// [ { "room": "~", "year": "~" }, ... ]
  @override
  List<Map<String, String>> get rooms;

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TeacherImplCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$$TeacherImplCopyWith(
          _$TeacherImpl value, $Res Function(_$TeacherImpl) then) =
      __$$TeacherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String firstName,
      String familyName,
      List<Map<String, String>> rooms});
}

/// @nodoc
class __$$TeacherImplCopyWithImpl<$Res>
    extends _$PersonCopyWithImpl<$Res, _$TeacherImpl>
    implements _$$TeacherImplCopyWith<$Res> {
  __$$TeacherImplCopyWithImpl(
      _$TeacherImpl _value, $Res Function(_$TeacherImpl) _then)
      : super(_value, _then);

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? firstName = null,
    Object? familyName = null,
    Object? rooms = null,
  }) {
    return _then(_$TeacherImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      familyName: null == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String,
      rooms: null == rooms
          ? _value._rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<Map<String, String>>,
    ));
  }
}

/// @nodoc

class _$TeacherImpl extends Teacher {
  const _$TeacherImpl(
      {required this.uid,
      required this.name,
      required this.firstName,
      required this.familyName,
      required final List<Map<String, String>> rooms})
      : _rooms = rooms,
        super._();

  @override
  final String uid;
  @override
  final String name;
  @override
  final String firstName;
  @override
  final String familyName;
// indexの低い方に最新のクラスが来る
  /// [ { "subject": "~", "room": "~", "year": "~", "text": "~" }, ... ]
  final List<Map<String, String>> _rooms;
// indexの低い方に最新のクラスが来る
  /// [ { "subject": "~", "room": "~", "year": "~", "text": "~" }, ... ]
  @override
  List<Map<String, String>> get rooms {
    if (_rooms is EqualUnmodifiableListView) return _rooms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rooms);
  }

  @override
  String toString() {
    return 'Person.teacher(uid: $uid, name: $name, firstName: $firstName, familyName: $familyName, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeacherImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            const DeepCollectionEquality().equals(other._rooms, _rooms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uid, name, firstName, familyName,
      const DeepCollectionEquality().hash(_rooms));

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      __$$TeacherImplCopyWithImpl<_$TeacherImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        $default, {
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        student,
    required TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)
        teacher,
  }) {
    return teacher(uid, name, firstName, familyName, rooms);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult? Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
  }) {
    return teacher?.call(uid, name, firstName, familyName, rooms);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        $default, {
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        student,
    TResult Function(String uid, String name, String firstName,
            String familyName, List<Map<String, String>> rooms)?
        teacher,
    required TResult orElse(),
  }) {
    if (teacher != null) {
      return teacher(uid, name, firstName, familyName, rooms);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Person value) $default, {
    required TResult Function(Student value) student,
    required TResult Function(Teacher value) teacher,
  }) {
    return teacher(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Person value)? $default, {
    TResult? Function(Student value)? student,
    TResult? Function(Teacher value)? teacher,
  }) {
    return teacher?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Person value)? $default, {
    TResult Function(Student value)? student,
    TResult Function(Teacher value)? teacher,
    required TResult orElse(),
  }) {
    if (teacher != null) {
      return teacher(this);
    }
    return orElse();
  }
}

abstract class Teacher extends Person {
  const factory Teacher(
      {required final String uid,
      required final String name,
      required final String firstName,
      required final String familyName,
      required final List<Map<String, String>> rooms}) = _$TeacherImpl;
  const Teacher._() : super._();

  @override
  String get uid;
  @override
  String get name;
  @override
  String get firstName;
  @override
  String get familyName; // indexの低い方に最新のクラスが来る
  /// [ { "subject": "~", "room": "~", "year": "~", "text": "~" }, ... ]
  @override
  List<Map<String, String>> get rooms;

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
