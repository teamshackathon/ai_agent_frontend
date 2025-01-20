import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/person/person.dart';
import 'package:code/data/room/room.dart';
import 'package:code/dummy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../toast.dart';

/// FireStoreから授業一覧を取得
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> getSubjects({required WidgetRef ref}) async {
  final statusNot = ref.read(personStatusProvider.notifier);
  final roomsNot = ref.read(roomsProvider.notifier);
  // try ~ catchでは例外が発生する処理を書く
  try {
    // firestoreからデータを受け取るならこうなる？
    // final doc = await FirebaseFirestore.instance
    //     .collection("years")
    //     .doc("2023")
    //     .collection("rooms")
    //     .doc(status.room)
    //     .collection("subjects")
    //     .get();
    // for(var sub in doc){
    //    docから科目を一つずつroomsにいれる処理
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
