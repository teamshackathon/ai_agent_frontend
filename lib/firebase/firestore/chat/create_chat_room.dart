import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../data/chat/chat_models.dart';
import '../../../data/firebase/chat_provider.dart';
import '../../../data/person/person.dart';
import '../../../data/firebase/lesson_stream.dart';

// ChatRoomIdを確認して作成する
Future<void> createChatRoom(
    {required WidgetRef ref, required String target}) async {
  final refrence = ref.watch(chatSetRefrenceProvider);
  final status = await ref.watch(personStatusProvider.future);

  final currentRoom = ref.watch(currentRoomProvider.notifier);

  final store = ref.watch(firestoreProvider);

  // chatIdとドキュメントIDは同じものを使う
  Logger().i("chatId: ${currentRoom.state.chatId}");

  // すでにチャットルームがある場合は作成しない
  final chatRoom =
      await store.collection("chats").doc(currentRoom.state.chatId).get();

  if (chatRoom.exists) {
    Logger().i("chat room already exists");
    return;
  }

  final newChat = ChatModel(
    chatId: "${currentRoom.state.chatId}-$target",
    chatName: "",
    isGroup: false,
    members: [status.folderName, "teacher"],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  await refrence.doc(newChat.chatId).set(newChat);
}
