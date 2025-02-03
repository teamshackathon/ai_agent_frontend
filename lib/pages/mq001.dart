// ignore_for_file: file_names

import 'package:code/dummy/widget/dummy_base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          var responce =
              await http.get(Uri.http('127.0.0.1:5000', 'api/endpoint'));
          // infoToast(log: responce);
          status.value = responce.statusCode.toString();
        },
      ),
      body: Text(status.value),
    );
  }
}
