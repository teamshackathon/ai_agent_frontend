// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import '../data/quiz/quiz.dart';
import '../dummy/widget/dummy_base_page.dart';

class DummyMain extends HookConsumerWidget {
  const DummyMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = useState("");

    return DummyBasePage(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var responce =
              await http.get(Uri.http('127.0.0.1:5000', 'api/endpoint'));
          status.value = responce.statusCode.toString();
        },
      ),
      body: Text(status.value),
    );
  }
}
