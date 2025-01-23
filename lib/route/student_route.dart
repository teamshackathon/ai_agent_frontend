// 長くなりそうなのでファイル分け

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/notification/notification.dart';
import '../pages/profile/profile.dart';
import '../pages/student/student_home.dart';
import '../widget/bottom_bar/student_bottom_bar.dart';
import 'route.dart';

// 各分岐の画面遷移を保持しておくのに使う。各ブランチに一つ
final _studentProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'studentProfile');
final _studentMainKey = GlobalKey<NavigatorState>(debugLabel: 'studentHome');
final _studentNotificationKey =
    GlobalKey<NavigatorState>(debugLabel: 'studentNotification');

// BottomNavigationBarみたいにルートをぶった切って遷移する実装が欲しい場合、
// ShellRouteを用いて、branchごとにそれぞれのページの遷移状態を保持しておける
final studentBranch = StatefulShellRoute.indexedStack(
  // 生徒用BottomBar呼び出し
  builder: (context, state, navigationShell) =>
      StudentBottomBar(navigationShell: navigationShell),

  // 生徒用画面はここに追加していく
  branches: [
    // プロフィール画面の分岐
    StatefulShellBranch(
      navigatorKey: _studentProfileKey,
      routes: [
        GoRoute(
          path: Routes.profile,
          builder: (context, state) => ProfilePage(),
        ),
      ],
    ),

    // 生徒メイン画面の分岐
    StatefulShellBranch(
      navigatorKey: _studentMainKey,
      routes: [
        GoRoute(
          path: Routes.studentMain,
          builder: (context, state) => StudentHome(),
        ),
      ],
    ),

    // 通知画面の分岐
    StatefulShellBranch(
      navigatorKey: _studentNotificationKey,
      routes: [
        GoRoute(
          path: Routes.notification,
          builder: (context, state) => NotificationPage(),
        ),
      ],
    ),
  ],
);
