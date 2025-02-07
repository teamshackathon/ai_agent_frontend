// 長くなりそうなのでファイル分け
import 'package:code/pages/chat/chat_to_ai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/profile/profile.dart';
import '../pages/student/activity/student_activity.dart';
import '../pages/student/main/student_lessons.dart';
import '../pages/student/main/student_main.dart';
import '../pages/student/main/tools/student_agenda.dart';
import '../pages/student/main/tools/student_quiz.dart';
import '../pages/student/main/tools/student_reading.dart';
import '../pages/student/main/student_tools.dart';
import '../pages/chat/chat_to_teacher.dart';
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
                      parentNavigatorKey: _studentMainKey,
                      path: "reading",
                      builder: (context, state) => StudentReading(),
                    ),
                    // GoRoute(
                    //   parentNavigatorKey: _studentMainKey,
                    //   path: "agenda",
                    //   builder: (context, state) => StudentAgenda(),
                    // ),
                    // GoRoute(
                    //   parentNavigatorKey: _studentMainKey,
                    //   path: "quiz",
                    //   builder: (context, state) => StudentQuiz(),
                    // ),
                  ],
                ),
                GoRoute(
                  parentNavigatorKey: _studentMainKey,
                  path: "chat/teacher",
                  builder: (context, state) => ChatTeacherRoomScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: _studentMainKey,
                  path: "chat/ai",
                  builder: (context, state) => ChatAIRoomScreen(),
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
