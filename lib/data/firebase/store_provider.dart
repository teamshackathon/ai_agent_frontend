import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/data/person/person.dart';
import 'package:code/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../notice/notice.dart';

/// firestoreのインスタンス監視用プロバイダー
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

/// noticeコレクションへの参照を持つset専用プロバイダー
///
/// 色々改良の余地がありそうだけど、一旦はこれで
final noticeSetReferenceProvider = Provider((ref) {
  final store = ref.watch(firestoreProvider);

  // noticeコレクションにまとめて入れるため、set,getで分けた
  return store.collection("notice").withConverter<Notice>(
        fromFirestore: ((snapshot, _) => Notice.fromFirestore(snapshot)),
        toFirestore: ((notice, _) {
          infoToast(log: notice.toMap());
          return notice.toMap();
        }),
      );
});

/// noticeコレクションへの参照を持つget専用プロバイダー
///
/// 色々改良の余地がありそうだけど、一旦はこれで
final noticeGetReferenceProvider = Provider((ref) {
  final store = ref.watch(firestoreProvider);
  final user = ref.watch(personStatusProvider);

  return store
      .collection("notice")
// 部屋とフォルダ名で誰宛てなのかを判断している。UIDで指定できるようにしたっていい
      .where("room", isEqualTo: user.rooms![0]["room"])
      .where("folderName", isEqualTo: user.folderName)
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
final noticesProvider = StreamProvider((ref) {
  final reference = ref.watch(noticeGetReferenceProvider);
  return reference.orderBy("timeStamp", descending: true).snapshots();
});
