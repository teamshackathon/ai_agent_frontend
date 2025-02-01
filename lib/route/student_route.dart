// 長くなりそうなのでファイル分け

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/profile/profile.dart';
import '../pages/student/activity/student_activity.dart';
import '../pages/student/main/student_lessons.dart';
import '../pages/student/main/student_main.dart';
import '../pages/student/main/student_reading.dart';
import '../pages/student/main/student_tools.dart';
import '../pages/chat/chat.dart';
import '../widget/bottom_bar/student_bottom_bar.dart';
import 'route.dart';

// 各分岐の画面遷移を保持しておくのに使う。各ブランチに一つ
final _studentProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'studentProfile');
final _studentMainKey = GlobalKey<NavigatorState>(debugLabel: 'studentMain');
final _studentNotificationKey =
    GlobalKey<NavigatorState>(debugLabel: 'studentNotification');

// BottomNavigationBarみたいにルートをぶった切って遷移する実装が欲しい場合、
// ShellRouteを用いて、branchごとにそれぞれのページの遷移状態を保持しておける
final studentBranch = StatefulShellRoute.indexedStack(
  // 生徒用BottomBar呼び出し
  builder: (context, state, navigationShell) =>
      StudentBottomBar(navigationShell: navigationShell),

  // 生徒用画面はここに追加していく
  branches: <StatefulShellBranch>[
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
          parentNavigatorKey: _studentMainKey,
          path: Routes.studentMain,
          builder: (context, state) => StudentMain(),
          routes: [
            GoRoute(
              parentNavigatorKey: _studentMainKey,
              path: "lessons",
              builder: (context, state) => StudentLessons(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _studentMainKey,
                  path: "tools",
                  builder: (context, state) => StudentTools(),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: rootNavigatorKey,
                      path: "reading",
                      builder: (context, state) => StudentReading(),
                    ),
                  ],
                ),
                GoRoute(
                  parentNavigatorKey: _studentMainKey,
                  path: "chatroom",
                  builder: (context, state) => ChatRoomScreen(),
                )
              ],
            ),
          ],
        ),
      ],
    ),

    // 通知画面の分岐
    StatefulShellBranch(
      navigatorKey: _studentNotificationKey,
      routes: [
        GoRoute(
          path: Routes.activity,
          builder: (context, state) => StudentActivityPage(),
        ),
      ],
    ),
  ],
);
