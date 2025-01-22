import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/person/person.dart';
import '../../data/room/room.dart';
import '../../mock_data.dart';
import '../../toast.dart';

/// FireStoreから授業一覧を取得
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> getSubjects({required WidgetRef ref}) async {
  final status = ref.read(personStatusProvider);
  final roomsNot = ref.read(roomsProvider.notifier);
  // try ~ catchでは例外が発生する処理を書く
  try {
    final doc = await FirebaseFirestore.instance
        .collection("2024")
        .doc("1-1").collection("common").get();

    var data = doc.docs.map((e){
      return e.data();
    }).toList;
    infoToast(log: data);
    //
    // for (var e in doc.docs) {
    //   infoToast(log: e.id);
    // }



    roomsNot.init();
    for (var d in dummyRoomList) {
      await Future.delayed(Duration(milliseconds: 500));
      roomsNot.add(Room.fromJson(d));
    }
  } catch (e) {
    //失敗は全部ここに行く
    warningToast(toast: e.toString(), log: e.toString());
  }
}
