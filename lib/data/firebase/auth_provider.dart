import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/person/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../notice/notice.dart';

/// firebaseAuthのインスタンス（実体）監視用プロバイダー
///
/// FirebaseAuthはシングルトン
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

/// ログイン状態監視用プロバイダー
final authStateProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(authProvider);
  return firebaseAuth.authStateChanges();
});

/// firestoreのインスタンス監視用プロバイダー
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// noticeコレクションへの参照を持つプロバイダー
///
/// 色々改良の余地がありそうだけど、一旦はこれで
final noticesReferenceProvider = Provider((ref) {
  final store = ref.read(firestoreProvider);
  final user = ref.read(personStatusProvider);

  return store
      .collection("notice")
// 部屋とフォルダ名で誰宛てなのかを判断している。UIDで指定できるようにしたっていい
      .where("room", isEqualTo: user.rooms![0])
      .where("name", isEqualTo: user.folderName)
// ひとまずは20件だけ読み込まれる設定。更に過去の通知を見に行けるようにしたいなら要相談
      .limit(20)
// ここでNoticeクラスに変換して渡せるようにしている
      .withConverter<Notice>(
        fromFirestore: ((snapshot, _) => Notice.fromFirestore(snapshot)),
        toFirestore: ((notice, _) => notice.toMap()),
      );
});

/// noticeReferenceProviderが指定する参照元から最新データを取り続けるプロバイダー
///
/// 最新データを保持してくれるため、改めてプロバイダーを用意する必要はない
///
/// タイムスタンプの新しい順に並び替えている
final noticesProvider = StreamProvider((ref){
  final reference = ref.read(noticesReferenceProvider);
  return reference.orderBy("timeStamp",descending: true).snapshots();
});