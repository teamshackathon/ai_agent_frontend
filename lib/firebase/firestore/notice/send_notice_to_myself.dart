import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/store_provider.dart';
import '../../../data/notice/notice.dart';
import '../../../data/person/person.dart';

Future<void> sendNoticeToMyself({required WidgetRef ref}) async {
  final reference = ref.watch(noticeSetReferenceProvider);
  final status = await ref.watch(personStatusProvider.future);

  final newNotice = Notice(
    timeStamp: DateTime.now(),
    title: "テスト",
    text: "テスト通知",
    publisher: "Myself",
    read: false,
    room: status.rooms[0]["room"] ?? "",
    folderName: status.folderName,
    reference: reference.doc(), // IDが勝手に入る
  );

  await newNotice.reference.set(newNotice);
}
