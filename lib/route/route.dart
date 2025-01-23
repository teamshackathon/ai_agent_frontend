import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/person/person.dart';
import '../data/firebase/firebase_provider.dart';
import '../dummy/data/dummy_provider.dart';
import '../dummy/route/dummy_route.dart';
import '../pages/login/login.dart';
import '../pages/dr001.dart';
import '../pages/dr002.dart';
import '../pages/et001.dart';
import '../pages/mq001.dart';
import '../pages/mq002.dart';
import '../pages/ss001.dart';
import '../pages/ss002.dart';
import '../pages/ss003.dart';
import '../pages/tq001.dart';
import 'student_route.dart';
import 'teacher_route.dart';

part 'route.g.dart';

/// ルート用ディレクトリ定数定義クラス
class Routes {
  static const String login = "/login";
  static const String teacherMain = "/teacher";
  static const String studentMain = "/student";
  static const String studentLessons = "/student/lessons";
  static const String makeQuizzes = "/quiz";
  static const String editQuizzes = "/quiz/edit";
  static const String submitStatus = "/ss001";
  static const String previewAnswer = "/ss002";
  static const String editAnswer = "/ss003";
  static const String takeQuizzes = "/tq001";
  static const String editText = "/et001";
  static const String displayResult = "/dr001";
  static const String requestFix = "/dr002";
  static const String profile = "/profile";
  static const String notification = "/notification";
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

///　ルータークラス
@riverpod
class Router extends _$Router {
  @override
  GoRouter build() {
    // ログイン状態に応じて、自動で画面遷移
    // firebase側でログイン状態を保持しておいてくれる
    final authState = ref.watch(authStateProvider);
    final status = ref.watch(personStatusProvider);
    String initialLocation = Routes.login;

    // ダミーモード用
    final dummy = ref.watch(dummyModeProvider);

    // ログイン状態で初期画面のページを選択。ここが変わると強制的に呼び戻される仕組みらしい
    // authStateはStreamデータなので、whenDataで状態に応じた処理を書ける
    // 画面乗っ取りもこれを使えばできるかも・・・？
    authState.whenData((user) {
      if (user == null) {
        initialLocation = Routes.login;
      } else if (dummy) {
        initialLocation = DummyRoutes.main;
      } else {
        initialLocation =
            status.role == "teacher" ? Routes.teacherMain : Routes.studentMain;
      }
    });

    return GoRouter(
      initialLocation: initialLocation,

      // 画面遷移を保持しておくのに使う。
      navigatorKey: rootNavigatorKey,

      // エラーを吐いた時に連れてくるページをここで決めるっぽい（調査不足）
      redirect: (context, state) {
        return null;
      },

      // 実際に遷移するページをここに並べる
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => LoginPage(),
        ),

        // ダミー用の分岐
        if (dummy) dummyBranch,

        // 先生用のbottomBarを含めた分岐
        if (status.role == "teacher") teacherBranch,

        // 生徒用のbottomBarを含めた分岐
        if (status.role == "student") studentBranch,

        // //
        // GoRoute(
        //   path: Routes.makeQuizzes,
        //   builder: (context, state) => MakeQuizzes(),
        // ),
        // GoRoute(
        //   path: Routes.editQuizzes,
        //   builder: (context, state) => EditQuizzes(),
        // ),
        // GoRoute(
        //   path: Routes.submitStatus,
        //   builder: (context, state) => SubmitStatus(),
        // ),
        // GoRoute(
        //   path: Routes.previewAnswer,
        //   builder: (context, state) => PreviewAnswer(),
        // ),
        // GoRoute(
        //   path: Routes.editAnswer,
        //   builder: (context, state) => EditAnswer(),
        // ),
        // GoRoute(
        //   path: Routes.editText,
        //   builder: (context, state) => EditText(),
        // ),
        // GoRoute(
        //   path: "/tq001",
        //   builder: (context, state) => TakeQuizzes(),
        // ),
        // GoRoute(
        //   path: "/dr001",
        //   builder: (context, state) => DisplayResult(),
        // ),
        // GoRoute(
        //   path: "/dr002",
        //   builder: (context, state) => RequestFix(),
        // ),
      ],
      debugLogDiagnostics: false,
    );
  }
}
