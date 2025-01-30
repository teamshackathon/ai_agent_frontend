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

@riverpod
Future<List<Room>> activeRooms(ref) async {
  // 生徒の現在のroom一覧作成
  Future<List<Room>> buildFromStudent(Student student) async {
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in student.rooms) {
      if (r["year"] == latestYear) {
        var docRef = store
            .collection(r["year"]!)
            .doc(r["room"]!)
            .collection("common");
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
    }

    // ここにたどり着いたときは、多分store側に部屋データがない
    // auth側に関してはpersonプロバイダーができてる限り問題ない
    if (list.isEmpty) {
      throw Exception("Error(buildFromStudent) : ROOMS IS EMPTY");
    }

    return list;
  }

  // 教師の現在のroom一覧作成
  List<Room> buildFromTeacher(Teacher teacher){
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in teacher.rooms) {
      if (r["year"] == latestYear) {
        list.add(
          Room(
            year: r["year"]!,
            roomNumber: r["room"]!,
            subject: r["subject"]!,
            reference: store
                .collection(r["year"]!)
                .doc(r["room"]!)
                .collection("common")
                .doc(r["subject"]!)
                .collection("lessons"),
          ),
        );
      }
    }

    // ここにたどり着いたときは、多分store側に部屋データがない
    // auth側に関してはpersonプロバイダーができてる限り問題ない
    if (list.isEmpty) {
      throw Exception("Error(buildFromStudent) : ROOMS IS EMPTY");
    }

    return list;
  }

  try {
    final Person person = await ref.read(personStatusProvider.future);

    if (person is Student) {
      return await buildFromStudent(person);
    } else if (person is Teacher) {
      return buildFromTeacher(person);
    }
    throw Exception("Error(Rooms) : ROLE IS UNFIT");
  } catch (e) {
    warningToast(log: e);
    return [];
  }
}

@riverpod
Future<List<Room>> archiveRooms(ref) async {
  // 生徒の過去のroom一覧作成
  Future<List<Room>> buildFromStudent(Student student) async {
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in student.rooms) {
      if (r["year"] != latestYear) {
        var docRef = store
            .collection(r["year"]!)
            .doc(r["room"]!)
            .collection("common");
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
    }

    // ここにたどり着いたときは、多分store側に部屋データがない
    // auth側に関してはpersonプロバイダーができてる限り問題ない
    if (list.isEmpty) {
      throw Exception("Error(buildFromStudent) : ROOMS IS EMPTY");
    }

    return list;
  }

  // 教師の過去のroom一覧作成
  List<Room> buildFromTeacher(Teacher teacher){
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in teacher.rooms) {
      if (r["year"] != latestYear) {
        list.add(
          Room(
            year: r["year"]!,
            roomNumber: r["room"]!,
            subject: r["subject"]!,
            reference: store
                .collection(r["year"]!)
                .doc(r["room"]!)
                .collection("common")
                .doc(r["subject"]!)
                .collection("lessons"),
          ),
        );
      }
    }

    // ここにたどり着いたときは、多分store側に部屋データがない
    // auth側に関してはpersonプロバイダーができてる限り問題ない
    if (list.isEmpty) {
      throw Exception("Error(buildFromStudent) : ROOMS IS EMPTY");
    }

    return list;
  }

  try {
    final Person person = await ref.read(personStatusProvider.future);

    if (person is Student) {
      return await buildFromStudent(person);
    } else if (person is Teacher) {
      return buildFromTeacher(person);
    }
    throw Exception("Error(Rooms) : ROLE IS UNFIT");
  } catch (e) {
    warningToast(log: e);
    return [];
  }
}