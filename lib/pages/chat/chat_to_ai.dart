import 'package:code/data/firebase/chat_provider.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/person/person.dart';
import 'package:code/widget/chat/message_card.dart';
import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/base_page/base_page.dart';

class ChatAIRoomScreen extends ConsumerWidget {
  const ChatAIRoomScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoomNot = ref.watch(currentRoomProvider.notifier);
    final user = ref.read(personStatusProvider.future);
    final messagesAsync =
        ref.watch(messagesStreamProvider("${currentRoomNot.state.chatId}-ai"));
    final messageController = TextEditingController();

    return BasePage(
      pageTitle: "[${currentRoomNot.state.subject}] Manabiya AIとの会話",
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: SakuraProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("読み込みエラー"));
                  } else {
                    return messagesAsync.when(
                      data: (messages) => ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          // 自分は文字を右側に表示、相手は左側に表示
                          final isMe =
                              message.senderId == snapshot.data?.folderName;
                          return isMe
                              ? IsMeMessageCard(message: message.text ?? "")
                              : TeacherMessageCard(message: message.text ?? "");
                        },
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text("Error: $err")),
                    );
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(labelText: "Aa"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (messageController.text.isNotEmpty) {
                      await _sendMessage(ref, messageController.text);
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(WidgetRef ref, String text) async {
    final store = ref.read(firestoreProvider);
    final status = await ref.read(personStatusProvider.future);
    final currentRoomNot = ref.watch(currentRoomProvider.notifier);
    final newMessageRef = store
        .collection("chats")
        .doc("${currentRoomNot.state.chatId}-ai")
        .collection("messages")
        .doc();
    await newMessageRef.set({
      "messageId": newMessageRef.id,
      "senderId": status.folderName, // TODO: Replace with actual user ID
      "text": text,
      "read": false,
      "createdAt": DateTime.now(),
    });
  }
}
