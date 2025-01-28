// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonImpl _$$LessonImplFromJson(Map<String, dynamic> json) => _$LessonImpl(
      id: json['id'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lessonsHash() => r'c1c3a6ea6cd9b1f2eb17c2a7ca9083b554d39968';

/// See also [Lessons].
@ProviderFor(Lessons)
final lessonsProvider = NotifierProvider<Lessons, List<Lesson>>.internal(
  Lessons.new,
  name: r'lessonsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lessonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Lessons = Notifier<List<Lesson>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
