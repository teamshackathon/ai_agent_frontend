// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:code/data/teacher/teacher.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../data/person/person.dart';
// import '../../../data/room/room.dart';
// import '../../../toast.dart';
//
// Map<String, String> subject = {
//   "japanese": "国語",
//   "math": "数学",
//   "english": "英語",
//   "science": "理科",
//   "social": "社会",
// };
//
// /// FireStoreから授業一覧を取得
// ///
// /// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
// Future<void> getRooms({required WidgetRef ref}) async {
//   final person = ref.watch(personStatusProvider);
//   final teachersNot = ref.read(teachersProvider.notifier);
//   final roomsNot = ref.read(roomsProvider.notifier);
//   final store = FirebaseFirestore.instance;
//   // try ~ catchでは例外が発生する処理を書く
//   try {
//     roomsNot.clear();
//
//     // 各年ごとにroomsに入れていく。年代も区別せずに一つの配列に入れる。
//     for (var r in person.rooms ?? []) {
//       // firestoreのフォルダを指定
//       var docRef = store
//           .collection(r["year"])
//           .doc(r["room"])
//           .collection(person.folderName);
//
//       //フォルダを持ってきて、roomsに入れていく
//       await docRef.get().then((querySnapshot) {
//         for (var doc in querySnapshot.docs) {
//           roomsNot.add(
//             Room(
//               id: doc.id,
//               name: subject[doc.id] ?? "",
//               // teachersはすでに読み込んでいるので、当てはまる先生を探す
//               teacher:
//                   teachersNot.inChargeOf(r["room"], r["year"], doc.id)?.name ??
//                       "",
//               year: r["year"],
//               roomNumber: r["room"],
//             ),
//           );
//         }
//       }, onError: (e) {
//         warningToast(log: e);
//         return throw Exception(e);
//       });
//     }
//   } catch (e) {
//     //失敗は全部ここに行く
//     warningToast(toast: e.toString(), log: e.toString());
//   }
// }
