// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Notice {
// タイムスタンプ
  DateTime get timeStamp => throw _privateConstructorUsedError; // 通知のタイトル
  String get title => throw _privateConstructorUsedError; // 通知本文
  String get text => throw _privateConstructorUsedError; // 通知を送った人の名前
  String get publisher => throw _privateConstructorUsedError; // 既読かどうか
  bool get read =>
      throw _privateConstructorUsedError; // firestore上の通知が置かれているところまでのPath
  DocumentReference<Object?> get reference =>
      throw _privateConstructorUsedError; // クラス名、名前は送信時にしか使わない引数
  String get room => throw _privateConstructorUsedError;
  String get folderName =>
      throw _privateConstructorUsedError; // 授業へのショートカットなどが入る予定。nullableな点に注意
  DocumentReference<Object?>? get shortcut =>
      throw _privateConstructorUsedError;

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeCopyWith<Notice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeCopyWith<$Res> {
  factory $NoticeCopyWith(Notice value, $Res Function(Notice) then) =
      _$NoticeCopyWithImpl<$Res, Notice>;
  @useResult
  $Res call(
      {DateTime timeStamp,
      String title,
      String text,
      String publisher,
      bool read,
      DocumentReference<Object?> reference,
      String room,
      String folderName,
      DocumentReference<Object?>? shortcut});
}

/// @nodoc
class _$NoticeCopyWithImpl<$Res, $Val extends Notice>
    implements $NoticeCopyWith<$Res> {
  _$NoticeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeStamp = null,
    Object? title = null,
    Object? text = null,
    Object? publisher = null,
    Object? read = null,
    Object? reference = null,
    Object? room = null,
    Object? folderName = null,
    Object? shortcut = freezed,
  }) {
    return _then(_value.copyWith(
      timeStamp: null == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      folderName: null == folderName
          ? _value.folderName
          : folderName // ignore: cast_nullable_to_non_nullable
              as String,
      shortcut: freezed == shortcut
          ? _value.shortcut
          : shortcut // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoticeImplCopyWith<$Res> implements $NoticeCopyWith<$Res> {
  factory _$$NoticeImplCopyWith(
          _$NoticeImpl value, $Res Function(_$NoticeImpl) then) =
      __$$NoticeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timeStamp,
      String title,
      String text,
      String publisher,
      bool read,
      DocumentReference<Object?> reference,
      String room,
      String folderName,
      DocumentReference<Object?>? shortcut});
}

/// @nodoc
class __$$NoticeImplCopyWithImpl<$Res>
    extends _$NoticeCopyWithImpl<$Res, _$NoticeImpl>
    implements _$$NoticeImplCopyWith<$Res> {
  __$$NoticeImplCopyWithImpl(
      _$NoticeImpl _value, $Res Function(_$NoticeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timeStamp = null,
    Object? title = null,
    Object? text = null,
    Object? publisher = null,
    Object? read = null,
    Object? reference = null,
    Object? room = null,
    Object? folderName = null,
    Object? shortcut = freezed,
  }) {
    return _then(_$NoticeImpl(
      timeStamp: null == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      publisher: null == publisher
          ? _value.publisher
          : publisher // ignore: cast_nullable_to_non_nullable
              as String,
      read: null == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as bool,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      folderName: null == folderName
          ? _value.folderName
          : folderName // ignore: cast_nullable_to_non_nullable
              as String,
      shortcut: freezed == shortcut
          ? _value.shortcut
          : shortcut // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
    ));
  }
}

/// @nodoc

class _$NoticeImpl extends _Notice {
  const _$NoticeImpl(
      {required this.timeStamp,
      required this.title,
      required this.text,
      required this.publisher,
      required this.read,
      required this.reference,
      required this.room,
      required this.folderName,
      this.shortcut})
      : super._();

// タイムスタンプ
  @override
  final DateTime timeStamp;
// 通知のタイトル
  @override
  final String title;
// 通知本文
  @override
  final String text;
// 通知を送った人の名前
  @override
  final String publisher;
// 既読かどうか
  @override
  final bool read;
// firestore上の通知が置かれているところまでのPath
  @override
  final DocumentReference<Object?> reference;
// クラス名、名前は送信時にしか使わない引数
  @override
  final String room;
  @override
  final String folderName;
// 授業へのショートカットなどが入る予定。nullableな点に注意
  @override
  final DocumentReference<Object?>? shortcut;

  @override
  String toString() {
    return 'Notice(timeStamp: $timeStamp, title: $title, text: $text, publisher: $publisher, read: $read, reference: $reference, room: $room, folderName: $folderName, shortcut: $shortcut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeImpl &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.folderName, folderName) ||
                other.folderName == folderName) &&
            (identical(other.shortcut, shortcut) ||
                other.shortcut == shortcut));
  }

  @override
  int get hashCode => Object.hash(runtimeType, timeStamp, title, text,
      publisher, read, reference, room, folderName, shortcut);

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeImplCopyWith<_$NoticeImpl> get copyWith =>
      __$$NoticeImplCopyWithImpl<_$NoticeImpl>(this, _$identity);
}

abstract class _Notice extends Notice {
  const factory _Notice(
      {required final DateTime timeStamp,
      required final String title,
      required final String text,
      required final String publisher,
      required final bool read,
      required final DocumentReference<Object?> reference,
      required final String room,
      required final String folderName,
      final DocumentReference<Object?>? shortcut}) = _$NoticeImpl;
  const _Notice._() : super._();

// タイムスタンプ
  @override
  DateTime get timeStamp; // 通知のタイトル
  @override
  String get title; // 通知本文
  @override
  String get text; // 通知を送った人の名前
  @override
  String get publisher; // 既読かどうか
  @override
  bool get read; // firestore上の通知が置かれているところまでのPath
  @override
  DocumentReference<Object?> get reference; // クラス名、名前は送信時にしか使わない引数
  @override
  String get room;
  @override
  String get folderName; // 授業へのショートカットなどが入る予定。nullableな点に注意
  @override
  DocumentReference<Object?>? get shortcut;

  /// Create a copy of Notice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeImplCopyWith<_$NoticeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
