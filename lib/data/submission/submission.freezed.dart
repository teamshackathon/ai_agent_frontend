// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Submission {
  List<Result> get testResults => throw _privateConstructorUsedError;
  List<Quiz> get homeworks => throw _privateConstructorUsedError;
  List<Result> get homeworkResults => throw _privateConstructorUsedError;
  DocumentReference<Object?> get reference =>
      throw _privateConstructorUsedError;

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubmissionCopyWith<Submission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmissionCopyWith<$Res> {
  factory $SubmissionCopyWith(
          Submission value, $Res Function(Submission) then) =
      _$SubmissionCopyWithImpl<$Res, Submission>;
  @useResult
  $Res call(
      {List<Result> testResults,
      List<Quiz> homeworks,
      List<Result> homeworkResults,
      DocumentReference<Object?> reference});
}

/// @nodoc
class _$SubmissionCopyWithImpl<$Res, $Val extends Submission>
    implements $SubmissionCopyWith<$Res> {
  _$SubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testResults = null,
    Object? homeworks = null,
    Object? homeworkResults = null,
    Object? reference = null,
  }) {
    return _then(_value.copyWith(
      testResults: null == testResults
          ? _value.testResults
          : testResults // ignore: cast_nullable_to_non_nullable
              as List<Result>,
      homeworks: null == homeworks
          ? _value.homeworks
          : homeworks // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
      homeworkResults: null == homeworkResults
          ? _value.homeworkResults
          : homeworkResults // ignore: cast_nullable_to_non_nullable
              as List<Result>,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubmissionImplCopyWith<$Res>
    implements $SubmissionCopyWith<$Res> {
  factory _$$SubmissionImplCopyWith(
          _$SubmissionImpl value, $Res Function(_$SubmissionImpl) then) =
      __$$SubmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Result> testResults,
      List<Quiz> homeworks,
      List<Result> homeworkResults,
      DocumentReference<Object?> reference});
}

/// @nodoc
class __$$SubmissionImplCopyWithImpl<$Res>
    extends _$SubmissionCopyWithImpl<$Res, _$SubmissionImpl>
    implements _$$SubmissionImplCopyWith<$Res> {
  __$$SubmissionImplCopyWithImpl(
      _$SubmissionImpl _value, $Res Function(_$SubmissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? testResults = null,
    Object? homeworks = null,
    Object? homeworkResults = null,
    Object? reference = null,
  }) {
    return _then(_$SubmissionImpl(
      testResults: null == testResults
          ? _value._testResults
          : testResults // ignore: cast_nullable_to_non_nullable
              as List<Result>,
      homeworks: null == homeworks
          ? _value._homeworks
          : homeworks // ignore: cast_nullable_to_non_nullable
              as List<Quiz>,
      homeworkResults: null == homeworkResults
          ? _value._homeworkResults
          : homeworkResults // ignore: cast_nullable_to_non_nullable
              as List<Result>,
      reference: null == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>,
    ));
  }
}

/// @nodoc

class _$SubmissionImpl extends _Submission {
  const _$SubmissionImpl(
      {required final List<Result> testResults,
      required final List<Quiz> homeworks,
      required final List<Result> homeworkResults,
      required this.reference})
      : _testResults = testResults,
        _homeworks = homeworks,
        _homeworkResults = homeworkResults,
        super._();

  final List<Result> _testResults;
  @override
  List<Result> get testResults {
    if (_testResults is EqualUnmodifiableListView) return _testResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_testResults);
  }

  final List<Quiz> _homeworks;
  @override
  List<Quiz> get homeworks {
    if (_homeworks is EqualUnmodifiableListView) return _homeworks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_homeworks);
  }

  final List<Result> _homeworkResults;
  @override
  List<Result> get homeworkResults {
    if (_homeworkResults is EqualUnmodifiableListView) return _homeworkResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_homeworkResults);
  }

  @override
  final DocumentReference<Object?> reference;

  @override
  String toString() {
    return 'Submission(testResults: $testResults, homeworks: $homeworks, homeworkResults: $homeworkResults, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubmissionImpl &&
            const DeepCollectionEquality()
                .equals(other._testResults, _testResults) &&
            const DeepCollectionEquality()
                .equals(other._homeworks, _homeworks) &&
            const DeepCollectionEquality()
                .equals(other._homeworkResults, _homeworkResults) &&
            (identical(other.reference, reference) ||
                other.reference == reference));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_testResults),
      const DeepCollectionEquality().hash(_homeworks),
      const DeepCollectionEquality().hash(_homeworkResults),
      reference);

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubmissionImplCopyWith<_$SubmissionImpl> get copyWith =>
      __$$SubmissionImplCopyWithImpl<_$SubmissionImpl>(this, _$identity);
}

abstract class _Submission extends Submission {
  const factory _Submission(
      {required final List<Result> testResults,
      required final List<Quiz> homeworks,
      required final List<Result> homeworkResults,
      required final DocumentReference<Object?> reference}) = _$SubmissionImpl;
  const _Submission._() : super._();

  @override
  List<Result> get testResults;
  @override
  List<Quiz> get homeworks;
  @override
  List<Result> get homeworkResults;
  @override
  DocumentReference<Object?> get reference;

  /// Create a copy of Submission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubmissionImplCopyWith<_$SubmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
