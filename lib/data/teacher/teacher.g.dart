// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeacherImpl _$$TeacherImplFromJson(Map<String, dynamic> json) =>
    _$TeacherImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      teach: (json['teach'] as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$$TeacherImplToJson(_$TeacherImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teach': instance.teach,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teachersHash() => r'fdeb18b872fcd493a62f170c094214e5faedac4a';

/// See also [Teachers].
@ProviderFor(Teachers)
final teachersProvider = NotifierProvider<Teachers, List<Teacher>>.internal(
  Teachers.new,
  name: r'teachersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$teachersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Teachers = Notifier<List<Teacher>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
