import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firebase/chat_provider.dart';
import '../../data/firebase/lesson_stream.dart';
import '../../data/person/person.dart';
import '../../widget/base_page/base_page.dart';
import '../../widget/chat/message_card.dart';
import '../../widget/utils/sakura_progress_indicator.dart';

class ChatTeacherRoomScreen extends HookConsumerWidget {
  const ChatTeacherRoomScreen({
    super.key,
  });

  Map<String, String> splitChatId(String chatId) {
    final split = chatId.split("-");
    return {
      "year": split[0],
      "room": "${split[1]}-${split[2]}",
      "teacher": split[3],
      "subject": split[4],
      "target": split[5],
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoomNot = ref.watch(currentRoomProvider.notifier);
    final user = ref.read(personStatusProvider.future);
    final messagesAsync = ref.watch(
        messagesStreamProvider("${currentRoomNot.state.chatId}-teacher"));
    final messageController = TextEditingController();

    final store = ref.read(firestoreProvider);
    final iconsRef = store.collection("basic").doc("icons");

    final name =
        splitChatId("${currentRoomNot.state.chatId}-teacher")["teacher"];

    final targetIconPath = useState("");
    final nameState = useState("");

    useEffect(() {
      Future<void> fetchData() async {
        final doc = await iconsRef.get();
        final data = doc.data() as Map<String, dynamic>;
        if (data.containsKey(name)) {
          targetIconPath.value = data[name]["icon_path"];
          nameState.value = data[name]["name"];
        }
      }

      fetchData();
      return null;
    }, []);

    return BasePage(
      pageTitle:
          "[${currentRoomNot.state.subject}] ${currentRoomNot.state.teacher}先生との会話",
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
                              ? IsMeMessageCard(
                                  message: message.text ?? "",
                                  name: snapshot.data?.name ?? "",
                                  iconPath: snapshot.data?.iconPath ?? "")
                              : TeacherMessageCard(
                                  message: message.text ?? "",
                                  name: nameState.value,
                                  iconPath: targetIconPath.value,
                                );
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
        .doc("${currentRoomNot.state.chatId}-teacher")
        .collection("messages")
        .doc();
    await newMessageRef.set({
      "messageId": newMessageRef.id,
      "senderId": status.folderName,
      "text": text,
      "read": false,
      "createdAt": DateTime.now(),
    });
  }
}
