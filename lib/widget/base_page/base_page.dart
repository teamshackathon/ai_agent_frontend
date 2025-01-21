// ページごとに共通する部分をまとめて変更できるように分離

import 'package:flutter/material.dart';

import '../../firebase/auth/logout/logout_firebase.dart';

/// ハンバーガーメニュー付きページの雛型
///
/// @args
///
/// (String?) pageTitle : ページ名
///
/// (Widget?) body : ページ本体
class BasePage extends StatelessWidget {
  const BasePage({super.key, this.pageTitle, this.body});

  // ページタイトル
  final String? pageTitle;

  // ページの本体部分
  final Widget? body;

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
      drawer: CustomDrawer(),

      // bodyに重なって表示されるボタン
      floatingActionButton: null,

      // ページ背景色
      backgroundColor: null,

      // bodyにWidgetが入っていなければ、Blank Pageと表示される
      body: body ?? Center(child: Text("BlankPage")),
    );
  }
}

/// ハンバーガーメニューの中身
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // メニューのヘッダー、childにWidgetを置くことで見た目をいじれる
          DrawerHeader(child: Text("メニュー")),

          // 以下、メニュー内容
          ListTile(
            title: Text("ログアウト"),
            onTap: () async => await logoutFirebase(),
          ),
        ],
      ),
    );
  }
}
