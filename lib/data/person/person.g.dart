// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonImpl _$$PersonImplFromJson(Map<String, dynamic> json) => _$PersonImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      roomIdList: (json['roomIdList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$PersonImplToJson(_$PersonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'roomIdList': instance.roomIdList,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$personStatusHash() => r'8b97f195f7aafd768e34f9d48bb2accb73da214b';

/// See also [PersonStatus].
@ProviderFor(PersonStatus)
final personStatusProvider = NotifierProvider<PersonStatus, Person>.internal(
  PersonStatus.new,
  name: r'personStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$personStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PersonStatus = Notifier<Person>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
