// ダミーのヘッダー

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase/auth/logout/logout_firebase.dart';
import '../data/dummy_provider.dart';

/// ハンバーガーメニュー付きページの雛型(ダミー)
///
/// @args
///
/// (String?) pageTitle : ページ名
///
/// (Widget?) body : ページ本体
class DummyBasePage extends StatelessWidget {
  const DummyBasePage({
    super.key,
    this.pageTitle,
    this.body,
    this.backgroundColor,
    this.floatingActionButton,
  });

  // ページタイトル
  final String? pageTitle;

  // ページの本体部分
  final Widget? body;

  final Color? backgroundColor;

  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    // Scaffold(足場)はページのベースになる設定を行うWidget

    return Scaffold(
      // 画面上部のバー(appBar)、今いるページ名を表示したりできる
      // スクロールに合わせて非表示にしたい場合は、別の作り方が必要
      appBar: AppBar(
        // タイトルが入力されていればタイトルを表示
        title: pageTitle == null ? null : Text(pageTitle!),

        // バー背景色
        backgroundColor: null,
      ),

      // ハンバーガーメニューの中身
      drawer: DummyCustomDrawer(),

      // bodyに重なって表示されるボタン
      floatingActionButton: floatingActionButton,

      // ページ背景色
      backgroundColor: backgroundColor,

      // bodyにWidgetが入っていなければ、Blank Pageと表示される
      body: body ?? Center(child: Text("BlankPage")),
    );
  }
}

/// ハンバーガーメニューの中身
class DummyCustomDrawer extends ConsumerWidget {
  const DummyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);

    return Drawer(
      child: ListView(
        children: [
          // メニューのヘッダー、childにWidgetを置くことで見た目をいじれる
          DrawerHeader(child: Text("ダミーメニュー")),

          // 以下、メニュー内容
          ListTile(
            title: Text("通常モード"),
            onTap: () => dummyNot.state = false,
          ),
          ListTile(
            title: Text("ログアウト"),
            onTap: () async {
              dummyNot.state = false;
              await logoutFirebase();
            },
          ),
        ],
      ),
    );
  }
}
