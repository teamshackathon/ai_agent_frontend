import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sakura/toast.dart';

part 'notice.freezed.dart';

@freezed
class Notice with _$Notice {
  const Notice._();

  // 通知データ。クラス、名前はfirestore側だけ持つ。
  const factory Notice({
    // タイムスタンプ
    required DateTime timeStamp,
    // 通知のタイトル
    required String title,
    // 通知本文
    required String text,
    // 通知を送った人の名前
    required String publisher,
    // 既読かどうか
    required bool read,
    // firestore上の通知が置かれているところまでのPath
    required DocumentReference reference,
    // クラス名、名前は送信時にしか使わない引数
    required String room,
    required String folderName,
    // 授業へのショートカットなどが入る予定。nullableな点に注意
    DocumentReference? shortcut,
  }) = _Notice;

  factory Notice.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data();
    return Notice(
      timeStamp: map != null && map["timeStamp"] != null
          ? map["timeStamp"].toDate()
          : DateTime.now(),
      title: map?["title"] ?? "",
      text: map?["text"] ?? "",
      publisher: map?["publisher"] ?? "",
      read: map?["read"] ?? false,
      reference: snapshot.reference,
      room: map?["room"] ?? "",
      folderName: map?["folderName"] ?? "",
      shortcut: map?["shortcut"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "timeStamp": FieldValue.serverTimestamp(),
      "room": room,
      "folderName": folderName,
      "publisher": publisher,
      "title": title,
      "text": text,
      "read": read,
      "shortcut": shortcut,
    };
  }
}
