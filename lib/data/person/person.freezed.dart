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

Person _$PersonFromJson(Map<String, dynamic> json) {
  return _Person.fromJson(json);
}

/// @nodoc
mixin _$Person {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get familyName => throw _privateConstructorUsedError;
  String? get room => throw _privateConstructorUsedError;

  /// Serializes this Person to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

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
      String role,
      String? firstName,
      String? familyName,
      String? room});
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
    Object? role = null,
    Object? firstName = freezed,
    Object? familyName = freezed,
    Object? room = freezed,
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
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String role,
      String? firstName,
      String? familyName,
      String? room});
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
    Object? role = null,
    Object? firstName = freezed,
    Object? familyName = freezed,
    Object? room = freezed,
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
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      familyName: freezed == familyName
          ? _value.familyName
          : familyName // ignore: cast_nullable_to_non_nullable
              as String?,
      room: freezed == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonImpl extends _Person {
  const _$PersonImpl(
      {required this.uid,
      required this.name,
      required this.role,
      this.firstName,
      this.familyName,
      this.room})
      : super._();

  factory _$PersonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String role;
  @override
  final String? firstName;
  @override
  final String? familyName;
  @override
  final String? room;

  @override
  String toString() {
    return 'Person(uid: $uid, name: $name, role: $role, firstName: $firstName, familyName: $familyName, room: $room)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.familyName, familyName) ||
                other.familyName == familyName) &&
            (identical(other.room, room) || other.room == room));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, name, role, firstName, familyName, room);

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonImplCopyWith<_$PersonImpl> get copyWith =>
      __$$PersonImplCopyWithImpl<_$PersonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonImplToJson(
      this,
    );
  }
}

abstract class _Person extends Person {
  const factory _Person(
      {required final String uid,
      required final String name,
      required final String role,
      final String? firstName,
      final String? familyName,
      final String? room}) = _$PersonImpl;
  const _Person._() : super._();

  factory _Person.fromJson(Map<String, dynamic> json) = _$PersonImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get role;
  @override
  String? get firstName;
  @override
  String? get familyName;
  @override
  String? get room;

  /// Create a copy of Person
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PersonImplCopyWith<_$PersonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
