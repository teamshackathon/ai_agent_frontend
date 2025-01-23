import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/person/person.dart';
import '../../data/room/room.dart';
import '../../data/teacher/teacher.dart';
import '../../toast.dart';

Map<String, String> subjects = {
  "japanese": "国語",
  "math": "数学",
  "english": "英語",
  "science": "理科",
  "social": "社会",
};

/// FireStoreから教師一覧を取得
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> getTeachers({required WidgetRef ref}) async {
  final teachersNot = ref.read(teachersProvider.notifier);
  final store = FirebaseFirestore.instance;
  // try ~ catchでは例外が発生する処理を書く
  try {
    teachersNot.init();

    var docRef = store.collection("teachers");

    docRef.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        teachersNot.add(
          Teacher(
            id: doc.id,
            name: doc.data()["name"],
            teach: getTeachingList(doc.data()),
          ),
        );
      }
    }, onError: (e) {
      warningToast(log: e);
      return throw Exception(e);
    });
  } catch (e) {
    //失敗は全部ここに行く
    warningToast(toast: e.toString(), log: e.toString());
  }
}

List<Map<String, String>> getTeachingList(Map<String, dynamic> data) {
  final List<Map<String, String>> list = [];
  for (var subject in subjects.keys) {
    if (data[subject] != null) {
      for (var d in data[subject]) {
        list.add({"room": d["room"], "year": d["year"], "subject": subject});
      }
    }
  }
  return list;
}
