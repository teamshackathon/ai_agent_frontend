import "dart:convert" as convert;

import 'package:code/data/room/room.dart';
import 'package:code/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../dummy.dart';
import '../data/person/person.dart';
import '../route/route.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = useState<String>("");
    final pass = useState<String>("");
    final displaySize = MediaQuery.of(context).size;
    final statusNot = ref.read(personStatusProvider.notifier);
    final registerLoad = useState<bool>(false);
    final loginLoad = useState<bool>(false);

    Future<void> registerFirebase() async {
      if (id.value == "") {
        Fluttertoast.showToast(msg: "アドレスが書かれていません");
        Logger().w("アドレスが書かれていません");
      } else if (pass.value.length < 6) {
        Fluttertoast.showToast(msg: "パスは６字以上にしてください");
        Logger().w("パスは６字以上にしてください");
      } else {
        try {
          final FirebaseAuth auth = FirebaseAuth.instance;
          final UserCredential result =
              await auth.createUserWithEmailAndPassword(
            email: id.value,
            password: pass.value,
          );
          final User user = result.user!;
          Logger().i(user.toString());
          Fluttertoast.showToast(msg: "登録成功！");
        } catch (e) {
          Fluttertoast.showToast(msg: "登録できませんでした");
          Logger().w("登録できませんでした");
        }
      }
    }

    Future<void> loginFirebase() async{
      if (id.value == "") {
        Fluttertoast.showToast(msg: "アドレスが書かれていません");
        Logger().w("アドレスが書かれていません");
      } else if (pass.value.length < 6) {
        Fluttertoast.showToast(msg: "パスは６字以上にしてください");
        Logger().w("パスは６字以上にしてください");
      } else {
        try {
          final FirebaseAuth auth = FirebaseAuth.instance;
          final UserCredential result =
          await auth.signInWithEmailAndPassword(
            email: id.value,
            password: pass.value,
          );
          final User user = result.user!;
          Logger().i(user.toString());
          Fluttertoast.showToast(msg: "ログイン成功！");
        } catch (e) {
          Fluttertoast.showToast(msg: "ログインできませんでした");
          Logger().w("ログインできませんでした");
        }
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: <Widget>[
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'ID(1:教師用,2:生徒用)'),
                onChanged: (str) {
                  id.value = str; //仮置き
                },
              ),
            ),
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (str) {
                  pass.value = str; //仮置き
                },
              ),
            ),
            LoadingButton(
              text: "登録",
              width: displaySize.width * 0.28,
              height: displaySize.width * 0.07,
              isLoading: registerLoad.value,
              enabled: !loginLoad.value,
              onPressed: () async {
                registerLoad.value = true;
                await registerFirebase();
                registerLoad.value = false;
              },
            ),
            SizedBox(
              height: displaySize.width * 0.05,
            ),
            LoadingButton(
              text: "ログイン",
              width: displaySize.width * 0.28,
              height: displaySize.width * 0.07,
              isLoading: loginLoad.value,
              enabled: !registerLoad.value,
              onPressed: () async {
                loginLoad.value = true;
                await loginFirebase();
                loginLoad.value = false;
              },
            ),
          ],
        ),
      ),
    );
  }
}
