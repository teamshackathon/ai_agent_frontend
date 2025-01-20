// todo : email_validatorいる？

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../firebase/auth/login/login_firebase.dart';
import '../../widget/loading_button.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ウィジェットを画面の大きさに依存させるために画面サイズを検出
    final displaySize = MediaQuery.of(context).size;
    // 再描画可能にするためにhooksのuseStateで宣言
    final id = useState<String>("");
    final pass = useState<String>("");
    final registerLoad = useState<bool>(false);
    final loginLoad = useState<bool>(false);

    // Scaffold(足場)はページのベースになる設定を行うWidget
    // ・画面上部のバー(appBar)、今いるページ名を表示したりできる
    // ・ページ本体(body)
    // ・bodyに重なって表示されるボタン(floatingActionButton) etc
    return Scaffold(
      // 子Widget(child)を親Widgetの中央に配置するWidget
      // 画面の中央ではなく、親Widgetの中央に配置する点に注意
      body: Center(
        // childrenに書かれたWidget達を縦に並べるWidget
        child: Column(
          // childrenを中央揃えにしている
          mainAxisAlignment: MainAxisAlignment.center,
          // children間の幅を設定
          spacing: 30,
          children: <Widget>[
            // 子Widgetのサイズをある程度指定するWidget
            SizedBox(
              // 大きさを画面サイズに依存して決定している
              width: displaySize.width * 0.8,

              // ユーザーが記入できるテキストフィールド
              child: TextField(
                // InputDecorationに色々追加することで、見た目等々がいじれる
                decoration: const InputDecoration(labelText: 'メールアドレス'),

                // ユーザーが何か文字を書くたびに呼び出される
                onChanged: (str) {
                  id.value = str;
                },
              ),
            ),

            // ほとんど↑と同じ
            SizedBox(
              width: displaySize.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                // obscureTextをtrueにすると、入力された文字を画面上で隠せる
                obscureText: true,
                onChanged: (str) {
                  pass.value = str;
                },
              ),
            ),

            // // 待っている間に中央でインジケータが表示されるボタン
            // LoadingButton(
            //   text: "登録",
            //   width: displaySize.width * 0.28,
            //   height: displaySize.width * 0.07,
            //
            //   // 読込中はここをtrue
            //   isLoading: registerLoad.value,
            //
            //   // 無効化したいときはここをfalse
            //   enabled: !loginLoad.value,
            //
            //   // 押されたときに登録処理
            //   // 処理中は他の行動ができないように、registerLoadにtrueを入れる
            //   onPressed: () async {
            //     registerLoad.value = true;
            //     await registerFirebase(email: id.value, pass: pass.value);
            //     registerLoad.value = false;
            //   },
            // ),
            //
            // // SizedBoxは隙間がほしいときにも使える
            // SizedBox(
            //   height: displaySize.width * 0.05,
            // ),

            // 前述のLoadingButtonとやってることは一緒
            LoadingButton(
              text: "ログイン",
              width: displaySize.width * 0.28,
              height: displaySize.width * 0.07,
              isLoading: loginLoad.value,
              enabled: !registerLoad.value,
              onPressed: () async {
                loginLoad.value = true;
                await loginFirebase(email: id.value, pass: pass.value, ref: ref);
                loginLoad.value = false;
              },
            ),
          ],
        ),
      ),
    );
  }
}
