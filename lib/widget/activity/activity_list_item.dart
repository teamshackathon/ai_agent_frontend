import 'package:flutter/material.dart';

import 'activity_popup_menu.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
    required this.read,
    required this.title,
    required this.text,
    required this.publisher,
    required this.timeStamp,
    required this.onUnread,
  });

  final bool read;
  final String title;
  final String text;
  final String publisher;
  final DateTime timeStamp;
  final void Function() onUnread;

  String dataTimeToString(DateTime dateTime) {
    // 時間ごとに表示を変える, 一週間以上前は日付を表示
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays > 7) {
      return "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    } else if (diff.inDays > 0) {
      return "${diff.inDays}日前";
    } else if (diff.inHours > 0) {
      return "${diff.inHours}時間前";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}分前";
    } else {
      return "たった今";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: ListTile(
          leading: read
              ? Icon(Icons.mark_email_read)
              : Icon(Icons.mark_email_unread),
          selected: !read,
          enabled: !read,
          title: Flex(
            direction: Axis.horizontal,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                dataTimeToString(timeStamp),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(direction: Axis.horizontal, children: [
                Icon(Icons.person),
                Text(
                  publisher,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ]),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
          trailing: ActivityPopupMenu(onUnread: onUnread),
        )),
      ],
    );
  }
}
