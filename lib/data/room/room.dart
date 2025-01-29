// todo : ofActive, ofArchived
// todo : currentRoomProvider

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/toast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../person/person.dart';

part 'room.freezed.dart';

part 'room.g.dart';

// これダサいね
const latestYear = "2024";

@freezed
class Room with _$Room {
  const Room._();

  // 一旦先生情報を保持することをやめた
  // （UI的にいらなそうだったのと、教師一覧を毎回持ってくるのが面倒）
  const factory Room({
    required String year,
    required String roomNumber,
    required String subject,
    // 各授業のlessonsまでのpathを保持しておく
    required CollectionReference reference,
  }) = _Room;
}

//教室用配列プロバイダー
@riverpod
Future<List<Room>> rooms(ref) async{
  try {
    final Person person = await ref.read(personStatusProvider.future);

    if (person is Student) {
      return await buildFromStudent(person);
    } else if (person is Teacher) {
      return await buildFromTeacher(person);
    }
    throw Exception("Error(Rooms) : ROLE IS UNFIT");
  } catch (e) {
    warningToast(log: e);
    return [];
  }
}

Future<List<Room>> buildFromStudent(Student student) async {
  final List<Room> list = [];
  final store = FirebaseFirestore.instance;
  for (var r in student.rooms) {
    var docRef =
    store.collection(r["year"]!).doc(r["room"]!).collection("common");
    await docRef.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        list.add(
          Room(
            year: r["year"]!,
            roomNumber: r["room"]!,
            subject: doc.id,
            reference: docRef.doc(doc.id).collection("lessons"),
          ),
        );
      }
    }, onError: (e) => throw Exception(e));
  }

  // ここにたどり着いたときは、多分store側に部屋データがない
  // auth側に関してはpersonプロバイダーができてる限り問題ない
  if (list.isEmpty){
    throw Exception("Error(buildFromStudent) : ROOMS IS EMPTY");
  }

  return list;
}

// 教師のクラス一覧作成
Future<List<Room>> buildFromTeacher(Teacher teacher) async {
  final List<Room> list = [];
  final store = FirebaseFirestore.instance;
  for (var r in teacher.rooms) {
    var docRef = store
        .collection(r["year"]!)
        .doc(r["room"]!)
        .collection("common")
        .doc(r["subject"]!);
    await docRef.get().then((doc) {
      list.add(
        Room(
          year: r["year"]!,
          roomNumber: r["room"]!,
          subject: r["subject"]!,
          reference: docRef.collection("lessons"),
        ),
      );
    }, onError: (e) => throw Exception(e));
  }

  // ここにたどり着いたときは、多分store側に部屋データがない
  // auth側に関してはpersonプロバイダーができてる限り問題ない
  if (list.isEmpty){
    throw Exception("Error(buildFromStudent) : ROOMS IS EMPTY");
  }

  return list;
}

@riverpod
Future<List<Room>> activeRooms(ref)async{
  final List<Room> list = [];
  final rooms = await ref.read(roomsProvider.future);
  for(final room in rooms){
    if(room.year == latestYear)list.add(room);
  }

  return list;
}

@riverpod
Future<List<Room>> archiveRooms(ref)async{
  final List<Room> list = [];
  final rooms = await ref.read(roomsProvider.future);
  for(final room in rooms){
    if(room.year != latestYear)list.add(room);
  }

  return list;
}
