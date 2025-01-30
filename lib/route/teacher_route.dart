// 長くなりそうなのでファイル分け

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/profile/profile.dart';
import '../pages/teacher/activity/teacher_activity.dart';
import '../pages/teacher/main/teacher_lessons.dart';
import '../pages/teacher/main/teacher_main.dart';
import '../pages/teacher/main/teacher_tools.dart';
import '../widget/bottom_bar/teacher_bottom_bar.dart';
import 'route.dart';

// 各分岐の画面遷移を保持しておくのに使う。各ブランチに一つ
final _teacherProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'teacherProfile');
final _teacherMainKey = GlobalKey<NavigatorState>(debugLabel: 'teacherMain');
final _teacherNotificationKey =
    GlobalKey<NavigatorState>(debugLabel: 'teacherNotification');

// BottomNavigationBarみたいにルートをぶった切って遷移する実装が欲しい場合、
// ShellRouteを用いて、branchごとにそれぞれのページの遷移状態を保持しておける
final teacherBranch = StatefulShellRoute.indexedStack(
  // 先生用BottomBar呼び出し
  builder: (context, state, navigationShell) =>
      TeacherBottomBar(navigationShell: navigationShell),

  // 先生用画面はここに追加していく
  branches: [
    // プロフィール画面の分岐
    StatefulShellBranch(
      navigatorKey: _teacherProfileKey,
      routes: [
        GoRoute(
          path: Routes.profile,
          builder: (context, state) => ProfilePage(),
        ),
      ],
    ),

    // 教師メイン画面の分岐
    StatefulShellBranch(
      navigatorKey: _teacherMainKey,
      routes: [
        GoRoute(
          path: Routes.teacherMain,
          builder: (context, state) => TeacherMain(),
          routes: [
            GoRoute(
              parentNavigatorKey: _teacherMainKey,
              path: "lessons",
              builder: (context, state) => TeacherLessons(),
              routes: [
                GoRoute(
                  parentNavigatorKey: _teacherMainKey,
                  path: "tools",
                  builder: (context, state) => TeacherTools(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // 通知画面の分岐
    StatefulShellBranch(
      navigatorKey: _teacherNotificationKey,
      routes: [
        GoRoute(
          path: Routes.activity,
          builder: (context, state) => TeacherActivityPage(),
        ),
      ],
    ),
  ],
);
