// ここらへんの処理がゴチャついてくるかもしれないので分割
//
// todo : タイムアウト実装
// todo : エラーコード細分化

import 'package:firebase_auth/firebase_auth.dart';

import '../../../toast.dart';

/// Firebaseへメアドとパスワードで登録
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> registerFirebase({
  required String email,
  required String pass,
}) async {
  // try ~ catchでは例外が発生する処理を書く
  try {
    // 失敗してそうなところでthrowを書くと、以降の処理をやめて、catchまで行く
    if (email == "") throw Exception("アドレスが書かれていません");
    if (pass.length < 6) throw Exception("パスは６字以上にしてください");

    // Authと通信するためのインスタンス（実体）を呼んでくる
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Authにアカウント登録をお願いする
    // awaitと書かれた処理以降は、awaitが終わるまで処理されない
    final UserCredential result = await auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );

    // resultを確認して、userの中にデータが入っていれば登録成功
    final User? user = result.user;
    if (user == null) throw Exception("通信に失敗しました");
    infoToast(toast: "登録成功", log: "登録成功");
  } catch (e) {
    //失敗は全部ここに行く
    warningToast(toast: e.toString(), log: e.toString());
  }
}
