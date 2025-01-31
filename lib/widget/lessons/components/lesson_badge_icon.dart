import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatToTeacherBadgeIcon extends HookConsumerWidget {
  const ChatToTeacherBadgeIcon({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // stream作成次第変更
    return Column(children: [
      Badge.count(
          count: 3,
          backgroundColor: Colors.lightBlue,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.chat))),
      Text("先生に聞く"),
    ]);
  }
}

class ChatToAIBadgeIcon extends HookConsumerWidget {
  const ChatToAIBadgeIcon({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // stream作成次第変更
    return Column(children: [
      Badge.count(
          count: 3,
          backgroundColor: Colors.pinkAccent,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.smart_toy))),
      Text("AIに聞く"),
    ]);
  }
}

class AnalyticsBadgeIcon extends HookConsumerWidget {
  const AnalyticsBadgeIcon({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // stream作成次第変更
    return Column(children: [
      Badge(
          label: Text("new"),
          backgroundColor: Colors.blue,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.analytics))),
      Text("自己分析する"),
    ]);
  }
}
