// 長くなりそうなのでファイル分け
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/chat/chat_to_ai.dart';
import '../pages/chat/chat_to_student.dart';
import '../pages/profile/profile.dart';
import '../pages/teacher/activity/teacher_activity.dart';
import '../pages/teacher/main/teacher_lessons.dart';
import '../pages/teacher/main/teacher_main.dart';
import '../pages/teacher/main/teacher_tools.dart';
import '../pages/teacher/main/tools/teacher_reading.dart';
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
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _teacherMainKey,
                      path: "reading",
                      builder: (context, state) => TeacherReading(),
                    ),
                    // GoRoute(
                    //   parentNavigatorKey: _teacherMainKey,
                    //   path: "agenda",
                    //   builder: (context, state) => TeacherAgenda(),
                    // ),
                    // GoRoute(
                    //   parentNavigatorKey: _teacherMainKey,
                    //   path: "quiz",
                    //   builder: (context, state) => TeacherQuiz(),
                    // ),
                  ],
                ),
                // GoRoute(
                //   parentNavigatorKey: _teacherMainKey,
                //   path: "create",
                //   builder: (context, state) => TeacherCreateLesson(),
                // ),
                GoRoute(
                  parentNavigatorKey: _teacherMainKey,
                  path: "chat/ai",
                  builder: (context, state) => ChatAIRoomScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: _teacherMainKey,
                  path: "chat/students",
                  builder: (context, state) => ChatListScreen(),
                ),
                GoRoute(
                  parentNavigatorKey: _teacherMainKey,
                  path: "chat/student",
                  builder: (context, state) =>
                      ChatStudentRoomScreen(state: state),
                )
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
