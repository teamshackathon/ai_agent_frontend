import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:logger/logger.dart';

part 'room.freezed.dart';

part 'room.g.dart';

/// @param
///
/// (String)id　授業の固有ID,
///
/// (String)name　授業の名前,
///
/// (String)teacherID　教師のID,
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

//教室用プロバイダー
@Riverpod(keepAlive: true)
class Rooms extends _$Rooms {
  @override
  List<Room> build() => [];

  ///@args なし
  ///
  ///stateを空リストに変更
  void reset() => state = [];

  ///@args (Room)Room
  ///
  ///stateにRoomを追加
  void add(Room room) => state = [...state, room];
}

void mapListToRooms(WidgetRef ref, List<dynamic> mapList) {
  final roomsNot = ref.read(roomsProvider.notifier);
  roomsNot.reset();
  for (var map in mapList) {
    roomsNot.add(Room.fromJson(map));
  }
}
