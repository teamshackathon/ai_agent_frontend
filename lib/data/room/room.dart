import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/toast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../person/person.dart';

part 'room.freezed.dart';

part 'room.g.dart';

// これダサいね
const latestYear = "2024";

const Map<String, String> subjects = {
  "japanese": "国語",
  "math": "数学",
  "science": "理科",
  "social": "社会",
  "english": "英語",
};

@freezed
class Room with _$Room {
  const Room._();

  // 一旦先生情報を保持することをやめた
  // （UI的にいらなそうだったのと、教師一覧を毎回持ってくるのが面倒）
  const factory Room({
    required String year,
    required String roomNumber,
    required String subject,
    required String chatId,
    // 各授業のlessonsまでのpathを保持しておく
    required CollectionReference reference,
    // 各授業の個人のlessonsまでのpathを保持しておく
    required CollectionReference ownReference,
    required String teacher,
  }) = _Room;

  String get displaySubject => subjects[subject] ?? "";

  factory Room.isBlank() {
    return Room(
      year: "",
      roomNumber: "",
      subject: "",
      chatId: "",
      reference: FirebaseFirestore.instance.collection("2024"),
      ownReference: FirebaseFirestore.instance.collection("2024"),
      teacher: "",
    );
  }
}

@riverpod
Future<List<Room>> activeRooms(ref) async {
  // 生徒の現在のroom一覧作成
  Future<List<Room>> buildFromStudent(Student student) async {
    final List<Room> list = [];
    final Map<String, String> chatIds = {};
    final store = FirebaseFirestore.instance;
    for (var r in student.rooms) {
      if (r["year"] == latestYear) {
        var docRef =
            store.collection(r["year"]!).doc(r["room"]!).collection("common");
        var ownDocRef = store
            .collection(r["year"]!)
            .doc(r["room"]!)
            .collection(student.folderName);
        await ownDocRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            chatIds[doc.id] = doc.data()["chatId"] ?? "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}";
          }
        }, onError: (e) => throw Exception(e));
        await docRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            list.add(
              Room(
                year: r["year"]!,
                roomNumber: r["room"]!,
                subject: doc.id,
                chatId: chatIds[doc.id] ?? "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}",
                ownReference: ownDocRef.doc(doc.id).collection("lessons"),
                reference: docRef.doc(doc.id).collection("lessons"),
                teacher: doc.data()["teacher"] ?? "",
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
  List<Room> buildFromTeacher(Teacher teacher) {
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in teacher.rooms) {
      if (r["year"] == latestYear) {
        list.add(
          Room(
              year: r["year"]!,
              roomNumber: r["room"]!,
              subject: r["subject"]!,
              chatId: "", // 教師はchatIdを持たない
              ownReference: store.collection(r["year"]!), // 教師は個人のlessonsを持たない
              reference: store
                  .collection(r["year"]!)
                  .doc(r["room"]!)
                  .collection("common")
                  .doc(r["subject"]!)
                  .collection("lessons"),
              teacher: teacher.name),
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
    final Map<String, String> chatIds = {};
    final store = FirebaseFirestore.instance;
    for (var r in student.rooms) {
      if (r["year"] != latestYear) {
        var docRef =
            store.collection(r["year"]!).doc(r["room"]!).collection("common");
        var ownDocRef = store
            .collection(r["year"]!)
            .doc(r["room"]!)
            .collection(student.folderName);
        await ownDocRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            chatIds[doc.id] = doc.data()["chatId"] ?? "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}";
          }
        }, onError: (e) => throw Exception(e));
        await docRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            list.add(
              Room(
                year: r["year"]!,
                roomNumber: r["room"]!,
                subject: doc.id,
                chatId: chatIds[doc.id] ?? "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}",
                ownReference: ownDocRef.doc(doc.id).collection("lessons"),
                reference: docRef.doc(doc.id).collection("lessons"),
                teacher: doc.data()["teacher"] ?? "",
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
  List<Room> buildFromTeacher(Teacher teacher) {
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in teacher.rooms) {
      if (r["year"] != latestYear) {
        list.add(
          Room(
            year: r["year"]!,
            roomNumber: r["room"]!,
            subject: r["subject"]!,
            chatId: "", // 教師はchatIdを持たない
            ownReference: store.collection(r["year"]!),
            reference: store
                .collection(r["year"]!)
                .doc(r["room"]!)
                .collection("common")
                .doc(r["subject"]!)
                .collection("lessons"),
            teacher: teacher.name,
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
