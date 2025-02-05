import 'dart:convert';

import 'package:code/test/audio_recorder_test.dart';
import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/quiz/quiz.dart';
import '../../widget/quiz/answer_widget.dart';
import '../data/dummy_provider.dart';
import '../widget/dummy_base_page.dart';
import 'package:http/http.dart' as http;

class DummyMain extends HookConsumerWidget {
  const DummyMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizNot = ref.read(quizNotifierProvider.notifier);
    final quiz = ref.watch(quizNotifierProvider);
    final status = useState("");

    return DummyBasePage(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var responce = await http.get(Uri.http(
              'localhost:3001', '/test_firebase', {'path': '2024/1-1'}));
          // infoToast(log: responce);
          status.value = responce.statusCode.toString();
        },
      ),
      body: Text(status.value),
    );
  }
}
