import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room.freezed.dart';

part 'room.g.dart';

@freezed
class Room with _$Room {
  const Room._();

  const factory Room({
    required String id,
    required String name,
    required String teacher,
    required String year,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

//教室用プロバイダー
@Riverpod(keepAlive: true)
class Rooms extends _$Rooms {
  @override
  List<Room> build() => [];

  ///stateを空リストに変更
  void init() => state = [];

  ///stateにRoomを追加
  void add(Room room) => state = [...state, room];
}

// void mapListToRooms(WidgetRef ref, List<dynamic> mapList) {
//   final roomsNot = ref.read(roomsProvider.notifier);
//   roomsNot.init();
//   for (var map in mapList) {
//     roomsNot.add(Room.fromJson(map));
//   }
// }
