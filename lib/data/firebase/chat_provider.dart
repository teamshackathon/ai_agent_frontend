import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../chat/chat_models.dart';

/// Firestoreのインスタンス監視用プロバイダー
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// chatsコレクションに新規チャットを追加するプロバイダー
final chatSetRefrenceProvider = Provider.autoDispose((ref) {
  final store = ref.watch(firestoreProvider);
  return store.collection("chats").withConverter<ChatModel>(
        fromFirestore: ((snapshot, _) => ChatModel.fromJson(snapshot.data()!)),
        toFirestore: ((chat, _) => chat.toJson()),
      );
});

/// chatsコレクションへの参照プロバイダー
final chatsCollectionProvider = Provider.autoDispose((ref) {
  final store = ref.watch(firestoreProvider);
  return store.collection("chats").withConverter<ChatModel>(
        fromFirestore: ((snapshot, _) => ChatModel.fromJson(snapshot.data()!)),
        toFirestore: ((chat, _) => chat.toJson()),
      );
});

/// messagesコレクションへの参照プロバイダー（特定のチャットルーム用）
final messagesCollectionProvider =
    Provider.family.autoDispose((ref, String chatId) {
  final store = ref.watch(firestoreProvider);
  return store
      .collection("chats")
      .doc(chatId)
      .collection("messages")
      .withConverter<MessageModel>(
        fromFirestore: ((snapshot, _) =>
            MessageModel.fromJson(snapshot.data()!)),
        toFirestore: ((message, _) => message.toJson()),
      );
});

/// チャット一覧を取得するStreamプロバイダー
final chatsStreamProvider = StreamProvider.autoDispose((ref) {
  final store = ref.watch(chatsCollectionProvider);
  return store
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
});

/// 指定したチャットのメッセージを取得するStreamプロバイダー
final messagesStreamProvider =
    StreamProvider.family.autoDispose((ref, String chatId) {
  final store = ref.watch(messagesCollectionProvider(chatId));
  return store
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
});
