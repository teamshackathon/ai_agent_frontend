import 'package:code/data/firebase/chat_provider.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/person/person.dart';
import 'package:code/firebase/firestore/chat/create_chat_room.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../widget/base_page/base_page.dart';

// class DummyNotificationPage extends ConsumerWidget {
//   const DummyNotificationPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final chatListAsync = ref.watch(chatsStreamProvider);
//     return BasePage(
//       pageTitle: "chat",
//       body: chatListAsync.when(
//         data: (chats) => ListView.builder(
//           itemCount: chats.length,
//           itemBuilder: (context, index) {
//             final chat = chats[index];
//             return ListTile(
//               title: Text(chat.chatId), // 仮の表示
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => ChatRoomScreen(chatId: chat.chatId),
//                 ),
//               ),
//             );
//           },
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text("Error: $err")),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => createChatRoom(ref: ref),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

class ChatRoomScreen extends ConsumerWidget {
  const ChatRoomScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoomNot = ref.watch(currentRoomProvider.notifier);
    final messagesAsync =
        ref.watch(messagesStreamProvider(currentRoomNot.state.chatId));
    final messageController = TextEditingController();

    return BasePage(
      pageTitle: "chatroom",
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) => ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ListTile(
                    title: Text(message.text ?? ""),
                    subtitle: Text("Sent by: ${message.senderId}"),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error: $err")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration:
                        const InputDecoration(labelText: "Enter message"),
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
        .doc(currentRoomNot.state.chatId)
        .collection("messages")
        .doc();
    await newMessageRef.set({
      "messageId": newMessageRef.id,
      "senderId": status.folderName, // TODO: Replace with actual user ID
      "text": text,
      "readBy": [],
      "createdAt": DateTime.now(),
    });
  }
}
