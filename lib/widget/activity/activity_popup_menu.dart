import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ActivityPopupMenu extends HookConsumerWidget {
  const ActivityPopupMenu({
    super.key,
    required this.onUnread,
  });

  // 未読にする処理
  final void Function() onUnread;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.mark_unread_chat_alt),
            title: Text("未読にする"),
          ),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          onUnread();
        }
      },
    );
  }
}
