// ここらへんの処理がゴチャついてくるかもしれないので分割
//
// todo : タイムアウト実装
// todo : エラーコード細分化

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/person/person.dart';
import '../../../toast.dart';

/// Firebaseへメアドとパスワードでログイン
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> loginFirebase({
  required String email,
  required String pass,
  required WidgetRef ref,
}) async {
  final statusNot = ref.read(personStatusProvider.notifier);
  // try ~ catchでは例外が発生する処理を書く
  try {
    // 失敗してそうなところでthrowを書くと、以降の処理をやめて、catchまで行く
    if (email == "") throw Exception("アドレスが書かれていません");
    if (pass.length < 6) throw Exception("パスは６字以上にしてください");

    // Authと通信するためのインスタンス（実体）を呼んでくる
    final FirebaseAuth auth = FirebaseAuth.instance;

    // Authにログインをお願いする
    // awaitと書かれた処理以降は、awaitが終わるまで処理されない
    final UserCredential result = await auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );

    // resultを確認して、userの中にデータが入っていればログイン
    final User? user = result.user;
    if (user == null) throw Exception("通信に失敗しました");

    // authのclaimsを取りに行く
    final token = await auth.currentUser?.getIdTokenResult();
    if (token == null) throw Exception("情報取得に失敗しました");

    infoToast(log: token.claims?["rooms"][0].toString());
    infoToast(log: token.claims?["rooms"][0].runtimeType);
    // infoToast(log: item.claims?);

    // jsonの中の配列が気持ち悪い形で出てくるから手直し
    final List<Map<String,String>> list = [];
    for (var item in token.claims?["rooms"]) {
      list.add(
          {"room": item["room"] as String, "year": item["year"] as String});
    }

    // 取ってきたデータからpersonStatusを更新
    statusNot.write(Person(
      uid: user.uid,
      name: user.displayName ?? "",
      role: token.claims?["role"],
      firstName: token.claims?["first_name"],
      familyName: token.claims?["family_name"],
      rooms: list,
    ));

    infoToast(toast: "ログイン成功", log: token.claims?["rooms"].toString());
  } catch (e) {
    //失敗は全部ここに行く
    warningToast(toast: e.toString(), log: e.toString());
  }
}
