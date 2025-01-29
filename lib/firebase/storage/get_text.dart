import 'package:code/data/pdf_path/pdf_path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../toast.dart';

/// FireStoreから教師一覧を取得
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> getText({required WidgetRef ref}) async {
  final pdfNot = ref.read(pdfPathProvider.notifier);
  // try ~ catchでは例外が発生する処理を書く
  try {
    pdfNot.clear();
    final storage = FirebaseStorage.instance;
    // 一時的にデータのURLを持ってくる仕様にしている
    // 本来はfirestoreにURLを保存し、それを読み込んでくる仕様にしていく
    var path = await storage.ref("englishMock.pdf").getDownloadURL();
    pdfNot.add(path);
  } on FirebaseException catch (e) {
    //失敗は全部ここに行く
    warningToast(log: "${e.code} : ${e.message}");
  }
}
