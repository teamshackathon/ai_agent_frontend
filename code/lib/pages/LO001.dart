// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';

final loginIdProvider = StateProvider<String>((ref) => ""); //仮置き
final loginPasswordProvider = StateProvider<String>((ref) => ""); //仮置き

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(loginIdProvider);
    final idNot = ref.read(loginIdProvider.notifier);
    final passNot = ref.read(loginPasswordProvider.notifier);
    final displaySize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: <Widget>[
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'ID(1:教師用,2:生徒用)'),
                onChanged: (str) {
                  idNot.state = str; //仮置き
                },
              ),
            ),
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (str) {
                  passNot.state = str; //仮置き
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                if (id == "1") {
                  context.push("/TM001");
                } else if (id == "2") {
                  context.push("/SM001");
                }
              },
              child: const Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
