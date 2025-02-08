import 'package:code/data/firebase/chat_provider.dart';
import 'package:code/data/firebase/lesson_stream.dart';
import 'package:code/data/person/person.dart';
import 'package:code/route/route.dart';
import 'package:code/widget/chat/message_card.dart';
import 'package:code/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/base_page/base_page.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatListAsync = ref.watch(chatsStreamProvider);
    final user = ref.read(personStatusProvider.future);
    final currentRoom = ref.watch(currentRoomProvider);

    // chatIDを文字分けする
    // 例: "2024-1-1-name.name-subject-target"
    // 2024年1年1組のname.name生徒とのsubjectのchat
    Map<String, String> splitChatId(String chatId) {
      final split = chatId.split("-");
      return {
        "year": split[0],
        "room": "${split[1]}-${split[2]}",
        "student": split[3],
        "subject": split[4],
        "target": split[5],
      };
    }

    return BasePage(
        pageTitle: "生徒との会話一覧",
        body: FutureBuilder(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: SakuraProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("読み込みエラー"));
              } else {
                return chatListAsync.when(
                  data: (chats) => ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      final chatId = chat.chatId;
                      final split = splitChatId(chatId);
                      final isMetalkChat = split["target"] == "teacher" &&
                          currentRoom.roomNumber == split["room"] &&
                          currentRoom.subject == split["subject"];
                      final chatReference =
                          "${split["year"]}-${split["room"]}-${split["student"]}-${split["subject"]}-teacher";
                      if (isMetalkChat) {
                        return ListTile(
                          title: Text("${split["student"]}さんとの会話"),
                          onTap: () {
                            GoRouter.of(context).push(Routes.chatStudent,
                                extra: {
                                  "chatId": chatReference,
                                  "name": split["student"]
                                });
                          },
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text("Error: $err")),
                );
              }
            }));
  }
}

class ChatStudentRoomScreen extends HookConsumerWidget {
  const ChatStudentRoomScreen({
    super.key,
    required this.state,
  });

  final GoRouterState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(personStatusProvider.future);
    final path =
        (state.extra as Map<String, dynamic>?)?["chatId"] as String? ?? "";
    final name =
        (state.extra as Map<String, dynamic>?)?["name"] as String? ?? "";
    final messagesAsync = ref.watch(messagesStreamProvider(path));
    final messageController = TextEditingController();

    final store = ref.read(firestoreProvider);
    final iconsRef = store.collection("basic").doc("icons");

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
      pageTitle: "生徒との会話",
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
                              : StudentMessageCard(
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
                      await _sendMessage(ref, messageController.text, path);
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

  Future<void> _sendMessage(WidgetRef ref, String text, String doc) async {
    final store = ref.read(firestoreProvider);
    final status = await ref.read(personStatusProvider.future);
    final newMessageRef =
        store.collection("chats").doc(doc).collection("messages").doc();
    await newMessageRef.set({
      "messageId": newMessageRef.id,
      "senderId": status.folderName,
      "text": text,
      "read": false,
      "createdAt": DateTime.now(),
    });
  }
}
