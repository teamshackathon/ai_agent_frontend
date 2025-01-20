// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonImpl _$$PersonImplFromJson(Map<String, dynamic> json) => _$PersonImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      firstName: json['firstName'] as String?,
      familyName: json['familyName'] as String?,
      room: json['room'] as String?,
    );

Map<String, dynamic> _$$PersonImplToJson(_$PersonImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'role': instance.role,
      'firstName': instance.firstName,
      'familyName': instance.familyName,
      'room': instance.room,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$personStatusHash() => r'36a413a2df668ed633b28c26bab08f75ff1b2148';

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
