import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../toast.dart';
import '../firebase/auth_provider.dart';
import '../firebase/store_provider.dart';

part 'person.freezed.dart';

part 'person.g.dart';

List<String> subjects = [
  "japanese",
  "math",
  "english",
  "science",
  "social",
];

@freezed
class Person with _$Person {
  const Person._();

  /// ユーザーのベースクラス
  const factory Person({
    required String uid,
    required String name,
    required String firstName,
    required String familyName,
    // indexの低い方に最新のクラスが来る
    /// [ { "room": "~", "year": "~" }, ... ]
    required List<Map<String, String>> rooms,
  }) = _Person;

  /// 生徒クラス
  const factory Person.student({
    required String uid,
    required String name,
    required String firstName,
    required String familyName,
    // indexの低い方に最新のクラスが来る
    /// [ { "room": "~", "year": "~" }, ... ]
    required List<Map<String, String>> rooms,
  }) = Student;

  /// 先生クラス
  const factory Person.teacher({
    required String uid,
    required String name,
    required String firstName,
    required String familyName,
    // indexの低い方に最新のクラスが来る
    /// [ { "subject": "~", "room": "~", "year": "~", "text": "~" }, ... ]
    required List<Map<String, String>> rooms,
  }) = Teacher;

  String get folderName => "$firstName.$familyName".toLowerCase();

  factory Person.isBlank() {
    return Person(uid: "", name: "", firstName: "", familyName: "", rooms: []);
  }
}

@riverpod
class PersonStatus extends _$PersonStatus {
  // 生徒としてビルド
  Student buildToStudent(User user, IdTokenResult token) {
    // claimsに名前が入っていなければthrow
    final firstName = token.claims?["first_name"];
    final familyName = token.claims?["family_name"];
    if (firstName == null || familyName == null) {
      throw Exception("Error(buildStudent) : NAME IS EMPTY");
    }

    // auth上に部屋データが入っていなければthrow
    final roomsData = token.claims?["rooms"];
    if (roomsData == null || roomsData == []) {
      throw Exception("Error(buildStudent) : ROOMS IS EMPTY");
    }

    // authの情報から生徒のクラス情報を入力
    final List<Map<String, String>> list = [];
    for (var item in roomsData) {
      list.add(
          {"room": item["room"] as String, "year": item["year"] as String});
    }

    // これが出るときはauth側でクラスデータが入ってない
    if (list.isEmpty) throw Exception("Error(buildToStudent) : ROOMS IS EMPTY");

    if (list.length > 1) {
      list.sort((a, b) => -a["year"]!.compareTo(b["year"]!));
    }

    return Student(
      uid: user.uid,
      name: user.displayName ?? "",
      firstName: firstName,
      familyName: familyName,
      rooms: list,
    );
  }

  // 先生としてビルド
  Future<Teacher> buildToTeacher(
    User user,
    IdTokenResult token,
  ) async {
    // claimsに名前が入っていなければthrow
    final firstName = token.claims?["first_name"];
    final familyName = token.claims?["family_name"];
    if (firstName == null || familyName == null) {
      throw Exception("Error(buildTeacher) : NAME IS EMPTY");
    }

    // firestoreのteachersからクラスデータを取得
    final folderName = "$firstName.$familyName".toLowerCase();
    final store = ref.watch(firestoreProvider);
    final docRef = store.collection("teachers").doc(folderName);
    final List<Map<String, String>> list = [];
    await docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      for (var subject in subjects) {
        if (data[subject] != null) {
          for (var d in data[subject]) {
            list.add({
              "subject": subject,
              "room": d["room"] ?? "",
              "year": d["year"] ?? "",
              "text": d["text"] ?? "",
            });
          }
        }
      }
    }, onError: (e) {
      throw Exception(e);
    });

    // ここにたどり着いたときは、多分store側のteachersがおかしい
    if (list.isEmpty) throw Exception("Error(buildToTeacher) : ROOMS IS EMPTY");

    // 最新、教科、クラスの優先度で並び替え
    if (list.length > 1) {
      list.sort((a, b) {
        if (a["year"] != b["year"]) {
          return -a["year"]!.compareTo(b["year"]!);
        } else if (a["subject"] != b["subject"]) {
          return subjects
              .indexOf(a["subject"]!)
              .compareTo(subjects.indexOf(b["subject"]!));
        } else {
          return a["room"]!.compareTo(b["room"]!);
        }
      });
    }

    return Teacher(
      uid: user.uid,
      name: user.displayName ?? "",
      firstName: firstName,
      familyName: familyName,
      rooms: list,
    );
  }

  @override
  Future<Person> build() async {
    try {
      final auth = ref.watch(authProvider);
      final user = auth.currentUser;

      // そもそもuserがnullになる仕様の時点でやばいから、今すぐ報告
      if (user == null) throw Exception("Error(PersonStatus) : USER IS NULL");

      // userの付加情報(claim)を見に行く
      final token = await user.getIdTokenResult();

      if (token.claims?["role"] == "student") {
        return buildToStudent(user, token);
      } else if (token.claims?["role"] == "teacher") {
        return await buildToTeacher(user, token);
      }

      // ここにたどり着いた場合、auth側に問題がある
      throw Exception("Error(PersonStatus) : ROLE IS NULL");
    } catch (e) {
      warningToast(log: e);
      return Person(
          uid: "", name: "", firstName: "", familyName: "", rooms: []);
    }
  }
}
