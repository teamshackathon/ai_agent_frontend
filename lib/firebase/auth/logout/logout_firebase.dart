import 'package:firebase_auth/firebase_auth.dart';

import '../../../toast.dart';

/// Firebaseへメアドとパスワードでログイン
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> logoutFirebase() async {
  // try ~ catchでは例外が発生する処理を書く
  try {
    // Authと通信するためのインスタンス（実体）を呼んでくる
    final FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();

    infoToast(toast: "ログアウト成功", log: "ログアウト成功");
  } catch (e) {
    //失敗は全部ここに行く
    warningToast(toast: e.toString(), log: e.toString());
  }
}
