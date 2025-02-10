// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Summary {
  String get markdown => throw _privateConstructorUsedError;
  List<String> get imgPaths => throw _privateConstructorUsedError;

  /// Create a copy of Summary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SummaryCopyWith<Summary> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SummaryCopyWith<$Res> {
  factory $SummaryCopyWith(Summary value, $Res Function(Summary) then) =
      _$SummaryCopyWithImpl<$Res, Summary>;
  @useResult
  $Res call({String markdown, List<String> imgPaths});
}

/// @nodoc
class _$SummaryCopyWithImpl<$Res, $Val extends Summary>
    implements $SummaryCopyWith<$Res> {
  _$SummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Summary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markdown = null,
    Object? imgPaths = null,
  }) {
    return _then(_value.copyWith(
      markdown: null == markdown
          ? _value.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String,
      imgPaths: null == imgPaths
          ? _value.imgPaths
          : imgPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SummaryImplCopyWith<$Res> implements $SummaryCopyWith<$Res> {
  factory _$$SummaryImplCopyWith(
          _$SummaryImpl value, $Res Function(_$SummaryImpl) then) =
      __$$SummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String markdown, List<String> imgPaths});
}

/// @nodoc
class __$$SummaryImplCopyWithImpl<$Res>
    extends _$SummaryCopyWithImpl<$Res, _$SummaryImpl>
    implements _$$SummaryImplCopyWith<$Res> {
  __$$SummaryImplCopyWithImpl(
      _$SummaryImpl _value, $Res Function(_$SummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of Summary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? markdown = null,
    Object? imgPaths = null,
  }) {
    return _then(_$SummaryImpl(
      markdown: null == markdown
          ? _value.markdown
          : markdown // ignore: cast_nullable_to_non_nullable
              as String,
      imgPaths: null == imgPaths
          ? _value._imgPaths
          : imgPaths // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$SummaryImpl extends _Summary {
  const _$SummaryImpl(
      {required this.markdown, required final List<String> imgPaths})
      : _imgPaths = imgPaths,
        super._();

  @override
  final String markdown;
  final List<String> _imgPaths;
  @override
  List<String> get imgPaths {
    if (_imgPaths is EqualUnmodifiableListView) return _imgPaths;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imgPaths);
  }

  @override
  String toString() {
    return 'Summary(markdown: $markdown, imgPaths: $imgPaths)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SummaryImpl &&
            (identical(other.markdown, markdown) ||
                other.markdown == markdown) &&
            const DeepCollectionEquality().equals(other._imgPaths, _imgPaths));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, markdown, const DeepCollectionEquality().hash(_imgPaths));

  /// Create a copy of Summary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SummaryImplCopyWith<_$SummaryImpl> get copyWith =>
      __$$SummaryImplCopyWithImpl<_$SummaryImpl>(this, _$identity);
}

abstract class _Summary extends Summary {
  const factory _Summary(
      {required final String markdown,
      required final List<String> imgPaths}) = _$SummaryImpl;
  const _Summary._() : super._();

  @override
  String get markdown;
  @override
  List<String> get imgPaths;

  /// Create a copy of Summary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SummaryImplCopyWith<_$SummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
