import 'package:code/data/firebase/chat_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/chat/chat_models.dart';
import '../../../data/person/person.dart';
import '../../../data/firebase/lesson_stream.dart';

// ChatRoomIdを確認して作成する
Future<void> createChatRoom({required WidgetRef ref}) async {
  final refrence = ref.watch(chatSetRefrenceProvider);
  final status = await ref.watch(personStatusProvider.future);

  // すでにチャットルームがあるか確認のてrefenceを取得　ちょっと考える
  final currentRoom = ref.watch(currentRoomProvider.notifier);

  final store = ref.watch(firestoreProvider);

  final data = store
      .collection(currentRoom.state.year)
      .doc(currentRoom.state.roomNumber)
      .collection(status.folderName)
      .doc(currentRoom.state.subject)
      .get();
  final chatId = data.then((value) => value.data()?["chatId"]);

  // chatIdとドキュメントIDは同じものを使う
  final newChat = ChatModel(
    chatId: currentRoom.state.chatId,
    chatName: "",
    isGroup: false,
    members: [status.folderName, "teacher"],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // チャットルームIDを設定
  await store
      .collection(currentRoom.state.year)
      .doc(currentRoom.state.roomNumber)
      .collection(status.folderName)
      .doc(currentRoom.state.subject)
      .update({"chatId": newChat.chatId});

  await refrence.doc(newChat.chatId).set(newChat);
}
