// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../data/lesson/lesson.dart';
// import '../../../data/person/student.dart';
// import '../../../data/room/room.dart';
// import '../../../data/teacher/teacher.dart';
// import '../../../toast.dart';
//
// /// FireStoreから教師一覧を取得
// ///
// /// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
// Future<void> getLessons({
//   required WidgetRef ref,
//   required String year,
//   required String room,
//   required String subject,
// }) async {
//   final lessonsNot = ref.read(lessonsProvider.notifier);
//   final store = FirebaseFirestore.instance;
//   // try ~ catchでは例外が発生する処理を書く
//   try {
//     lessonsNot.clear();
//
//     // とりあえずcommonの中から探す
//     var docRef = store
//         .collection(year)
//         .doc(room)
//         .collection("common")
//         .doc(subject)
//         .collection("lessons");
//
//     // 取ってきたデータをlessonsProviderに格納
//     docRef.get().then((querySnapshot) {
//       for (var doc in querySnapshot.docs) {
//         lessonsNot.add(Lesson(id: doc.id, count: doc.data()["count"]));
//       }
//     }, onError: (e) {
//       return throw Exception(e);
//     });
//   } catch (e) {
//     //失敗は全部ここに行く
//     warningToast(toast: e.toString(), log: e.toString());
//   }
// }
