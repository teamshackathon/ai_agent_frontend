import 'package:code/data/pdf/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../toast.dart';

/// FireStoreから教師一覧を取得
///
/// Futureと書かれていた時は、時間のかかる処理が含まれている（非同期処理）
Future<void> getText({required WidgetRef ref}) async {
  final pdfNot = ref.read(pdfProvider.notifier);
  // try ~ catchでは例外が発生する処理を書く
  try {
    pdfNot.init();
    final storage = FirebaseStorage.instance;
    var data = await storage.ref("englishMock.pdf").getData();
    if (data != null) pdfNot.add(data);
    infoToast(log:data!.isEmpty);
  } on FirebaseException catch (e) {
    //失敗は全部ここに行く
    warningToast(log: "${e.code} : ${e.message}");
  }
}
