import 'package:cloud_firestore/cloud_firestore.dart';
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
    required List<String> students,
    required String teacher,
    // データ名にしとくと、後から楽そう
    required String textDataName,
    required String teachingHours,
    required String numberOfTeachingHours,
    required String dateOfLessons,
    required String classrooms,
  }) = _Room;

  String get displaySubject => subjects[subject] ?? "";

  factory Room.isBlank() {
    return Room(
      year: "",
      roomNumber: "",
      subject: "",
      chatId: "",
      reference: FirebaseFirestore.instance.collection("2024"),
      students: [],
      teacher: "",
      textDataName: "",
      teachingHours: "",
      numberOfTeachingHours: "",
      dateOfLessons: "",
      classrooms: "",
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
            chatIds[doc.id] = doc.data()["chatId"] ??
                "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}";
          }
        }, onError: (e) => throw Exception(e));
        await docRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            list.add(
              Room(
                year: r["year"]!,
                roomNumber: r["room"]!,
                subject: doc.id,
                chatId: chatIds[doc.id] ??
                    "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}",
                students: [],
                reference: docRef.doc(doc.id).collection("lessons"),
                teacher: doc.data()["teacher"] ?? "",
                textDataName: doc.data()["text_link"] ?? "",
                teachingHours: doc.data()["teachingHours"] ?? "",
                numberOfTeachingHours:
                    doc.data()["numberOfTeachingHours"] ?? "",
                dateOfLessons: doc.data()["dateOfLessons"] ?? "",
                classrooms: doc.data()["classrooms"] ?? "",
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
  Future<List<Room>> buildFromTeacher(Teacher teacher) async {
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in teacher.rooms) {
      if (r["year"] == latestYear) {
        final List<String> students = [];
        await store
            .collection(r["year"]!)
            .doc(r["room"]!)
            .get()
            .then((snapshot) {
          for (var student in snapshot.data()!["collections"]) {
            students.add(student);
          }
        });

        var docRef =
            store.collection(r["year"]!).doc(r["room"]!).collection("common");
        await docRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc.id == r["subject"]) {
              list.add(
                Room(
                  year: r["year"]!,
                  roomNumber: r["room"]!,
                  subject: r["subject"]!,
                  chatId:
                      "${r["year"]}-${r["room"]}-${teacher.folderName}-${doc.id}",
                  // 教師はchatIdを持たない
                  reference: docRef.doc(r["subject"]!).collection("lessons"),
                  students: students,
                  teacher: teacher.name,
                  textDataName: doc.data()["text_link"] ?? "",
                  teachingHours: doc.data()["teachingHours"] ?? "",
                  numberOfTeachingHours:
                      doc.data()["numberOfTeachingHours"] ?? "",
                  dateOfLessons: doc.data()["dateOfLessons"] ?? "",
                  classrooms: doc.data()["classrooms"] ?? "",
                ),
              );
            }
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

  try {
    final Person person = await ref.read(personStatusProvider.future);

    if (person is Student) {
      return await buildFromStudent(person);
    } else if (person is Teacher) {
      return buildFromTeacher(person);
    }
    throw Exception("Error(Rooms) : ROLE IS UNFIT");
  } catch (e) {
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
            chatIds[doc.id] = doc.data()["chatId"] ??
                "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}";
          }
        }, onError: (e) => throw Exception(e));
        await docRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            list.add(
              Room(
                year: r["year"]!,
                roomNumber: r["room"]!,
                subject: doc.id,
                chatId: chatIds[doc.id] ??
                    "${r["year"]}-${r["room"]}-${student.folderName}-${doc.id}",
                students: [],
                reference: docRef.doc(doc.id).collection("lessons"),
                teacher: doc.data()["teacher"] ?? "",
                textDataName: doc.data()["text_link"] ?? "",
                teachingHours: doc.data()["teachingHours"] ?? "",
                numberOfTeachingHours:
                    doc.data()["numberOfTeachingHours"] ?? "",
                dateOfLessons: doc.data()["dateOfLessons"] ?? "",
                classrooms: doc.data()["classrooms"] ?? "",
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
  Future<List<Room>> buildFromTeacher(Teacher teacher) async {
    final List<Room> list = [];
    final store = FirebaseFirestore.instance;
    for (var r in teacher.rooms) {
      if (r["year"] != latestYear) {
        final List<String> students = [];

        await store
            .collection(r["year"]!)
            .doc(r["room"]!)
            .get()
            .then((snapshot) {
          for (var student in snapshot.data()!["collections"]) {
            students.add(student);
          }
        });

        var docRef =
            store.collection(r["year"]!).doc(r["room"]!).collection("common");

        await docRef.get().then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            if (doc.id == r["subject"]) {
              list.add(
                Room(
                  year: r["year"]!,
                  roomNumber: r["room"]!,
                  subject: r["subject"]!,
                  chatId: "",
                  // 教師はchatIdを持たない
                  reference: docRef.doc(r["subject"]!).collection("lessons"),
                  students: students,
                  teacher: teacher.name,
                  textDataName: doc.data()["text_link"] ?? "",
                  teachingHours: doc.data()["teachingHours"] ?? "",
                  numberOfTeachingHours:
                      doc.data()["numberOfTeachingHours"] ?? "",
                  dateOfLessons: doc.data()["dateOfLessons"] ?? "",
                  classrooms: doc.data()["classrooms"] ?? "",
                ),
              );
            }
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

  try {
    final Person person = await ref.read(personStatusProvider.future);

    if (person is Student) {
      return await buildFromStudent(person);
    } else if (person is Teacher) {
      return buildFromTeacher(person);
    }
    throw Exception("Error(Rooms) : ROLE IS UNFIT");
  } catch (e) {
    return [];
  }
}

Future<Room> searchRoom(List<Room> rooms, String subject) async {
  for (var room in rooms) {
    if (room.subject == subject) return room;
  }
  return Room.isBlank();
}
