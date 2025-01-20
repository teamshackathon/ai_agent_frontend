// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      teacherId: json['teacherId'] as String,
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teacherId': instance.teacherId,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomsHash() => r'a1c4aab8c0b4e74dcc8ad73af608ee5235925cde';

/// See also [Rooms].
@ProviderFor(Rooms)
final roomsProvider = NotifierProvider<Rooms, List<Room>>.internal(
  Rooms.new,
  name: r'roomsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Rooms = Notifier<List<Room>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
