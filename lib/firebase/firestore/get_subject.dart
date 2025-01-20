import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/person/person.dart';
import 'package:code/data/room/room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../toast.dart';

/// Firebaseへメアドとパスワードでログイン
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> getRooms({
  required String email,
  required String pass,
  required WidgetRef ref,
}) async {
  final statusNot = ref.read(personStatusProvider.notifier);
  final roomsNot = ref.read(roomsProvider.notifier);
  // try ~ catchでは例外が発生する処理を書く
  try {
    final doc = await FirebaseFirestore.instance.collection("year").doc("2023").collection(collectionPath)
  } catch (e) {
    //失敗は全部ここに行く
    warningToast(toast: e.toString(), log: e.toString());
  }
}
