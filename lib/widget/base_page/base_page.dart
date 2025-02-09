// ページごとに共通する部分をまとめて変更できるように分離

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../dummy/data/dummy_provider.dart';
import '../../firebase/auth/logout/logout_firebase.dart';

/// ハンバーガーメニュー付きページの雛型
///
/// @args
///
/// (String?) pageTitle : ページ名
///
/// (Widget?) body : ページ本体
class BasePage extends StatelessWidget {
  const BasePage({
    super.key,
    this.pageTitle,
    this.body,
    this.floatingActionButton,
  });

  // ページタイトル
  final String? pageTitle;

  // ページの本体部分
  final Widget? body;

  // ページに重なって表示されるボタン
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    // Scaffold(足場)はページのベースになる設定を行うWidget

    return Scaffold(
      // 画面上部のバー(appBar)、今いるページ名を表示したりできる
      // スクロールに合わせて非表示にしたい場合は、別の作り方が必要
      appBar: AppBar(
        // タイトルが入力されていればタイトルを表示
        title: Text(pageTitle ?? "", softWrap: false),

        // バー背景色
        backgroundColor: Colors.white,

        elevation: 10, // 数値を大きくすると濃くなります

        shadowColor: Colors.grey.withOpacity(0.5),
      ),

      // ハンバーガーメニューの中身
      drawer: CustomDrawer(),

      // bodyに重なって表示されるボタン
      floatingActionButton: floatingActionButton,

      // ページ背景色
      backgroundColor: null,

      // bodyにWidgetが入っていなければ、Blank Pageと表示される
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFB0E0E6),
              Color(0xFF87CEFA),
            ],
            begin: Alignment.topCenter, // 上部から開始
            end: Alignment.bottomCenter, // 下部に向かう
          ),
        ),
        child: body ?? Center(child: Text("BlankPage")),
      ),
    );
  }
}

/// ハンバーガーメニューの中身
class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dummyNot = ref.read(dummyModeProvider.notifier);

    return Drawer(
      child: ListView(
        children: [
          // メニューのヘッダー、childにWidgetを置くことで見た目をいじれる
          DrawerHeader(child: Text("メニュー")),

          // 以下、メニュー内容
          ListTile(
              title: Text("ダミーモード"),
              onTap: () {
                dummyNot.state = true;
              }),
          ListTile(
            title: Text("ログアウト"),
            onTap: () async => await logoutFirebase(),
          ),
        ],
      ),
    );
  }
}
