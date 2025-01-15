import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:logger/logger.dart';

part 'room.freezed.dart';

part 'room.g.dart';

@freezed
class Room with _$Room {
  const Room._();

  const factory Room({
    required String id,
    required String name,
    required String teacherId,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

@Riverpod(keepAlive: true)
class Rooms extends _$Rooms {
  @override
  List<Room> build() => [];

  void reset() => state = [];

  void add(Room room) => state = [...state, room];
}

void mapListToRooms(WidgetRef ref, List<dynamic> mapList) {
  final roomsNot = ref.read(roomsProvider.notifier);
  roomsNot.reset();
  for (var map in mapList){
    roomsNot.add(Room.fromJson(map));
  }
}
