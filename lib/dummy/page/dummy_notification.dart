import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../widget/dummy_base_page.dart';

class DummyNotificationPage extends HookConsumerWidget {
  const DummyNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = useState<List<String>>([]);
    final controller = useTextEditingController();

    // WebSocket の初期化
    final socket = useMemoized(() {
      final socket = io.io('http://10.0.2.2:5002', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      return socket;
    });

    useEffect(() {
      socket.on('connect', (_) {
        Logger().i('Connected to WebSocket server');
      });

      socket.on('message', (data) {
        messages.value = [...messages.value, data];
      });

      socket.on('disconnect', (_) {
        Logger().i('Disconnected from WebSocket server');
      });

      socket.on('error', (error) {
        Logger().e('WebSocket error: $error');
      });

      return () {
        socket.dispose();
      };
    }, [socket]);

    void sendMessage() {
      if (controller.text.isNotEmpty) {
        Logger().i(controller.text);
        socket.emit('message', controller.text);
        controller.clear();
      }
    }

    return DummyBasePage(
        pageTitle: "ダミー通知一覧(websocketの作成)",
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'メッセージを入力してください',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.value.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages.value[index]),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
