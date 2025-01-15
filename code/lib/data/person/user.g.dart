// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      roomIdList: (json['roomIdList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'roomIdList': instance.roomIdList,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userStatusHash() => r'70ceea8d722154a781f95d179bc91e9ff6459b26';

/// See also [PersonStatus].
@ProviderFor(PersonStatus)
final userStatusProvider = NotifierProvider<PersonStatus, Person>.internal(
  PersonStatus.new,
  name: r'userStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserStatus = Notifier<Person>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
