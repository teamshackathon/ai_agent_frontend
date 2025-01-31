// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScoreImpl _$$ScoreImplFromJson(Map<String, dynamic> json) => _$ScoreImpl(
      totalScore: (json['totalScore'] as num?)?.toInt() ?? -1,
      maxScore: (json['maxScore'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$ScoreImplToJson(_$ScoreImpl instance) =>
    <String, dynamic>{
      'totalScore': instance.totalScore,
      'maxScore': instance.maxScore,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scoreNotiferHash() => r'950e6ee2803eb4b9d2791b311f499b8e02d0ebcf';

/// See also [ScoreNotifer].
@ProviderFor(ScoreNotifer)
final scoreNotiferProvider = NotifierProvider<ScoreNotifer, Score>.internal(
  ScoreNotifer.new,
  name: r'scoreNotiferProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$scoreNotiferHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScoreNotifer = Notifier<Score>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
