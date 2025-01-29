// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../../../data/firebase/store_provider.dart';
// import '../../../data/notice/notice.dart';
//
// Future<void> sendNoticeToRoom({
//   required WidgetRef ref,
//   required String title,
//   required String text,
//   required String publisher,
//   required String room,
// }) async {
//   final reference = ref.watch(noticeSetReferenceProvider);
//
//   final list = await _getStudentFromRoom(ref: ref, room: room);
//   for (var folderName in list) {
//     final newNotice = Notice(
//       timeStamp: DateTime.now(),
//       title: title,
//       text: "テスト通知",
//       publisher: "Myself",
//       read: false,
//       room: room,
//       folderName: folderName,
//       reference: reference.doc(), // IDが勝手に入る
//     );
//
//     newNotice.reference.set(newNotice);
//   }
// }
//
// Future<List<String>> _getStudentFromRoom({
//   required WidgetRef ref,
//   required String room,
// }) async {
//   final store = ref.watch(firestoreProvider);
//   final data = await store.collection("2024").doc(room).get();
//   if (data.data() == null || data.data()?["collections"] == null) return [];
//   return data.data()?["collections"] as List<String>;
// }
