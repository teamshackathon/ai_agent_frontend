import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/firebase/auth_provider.dart';
import '../dummy/data/dummy_provider.dart';
import '../dummy/route/dummy_route.dart';
import '../pages/login/login.dart';
import '../pages/dr001.dart';
import 'student_route.dart';
import 'teacher_route.dart';

part 'route.g.dart';

/// ルート用ディレクトリ定数定義クラス
///
/// 正しい階層構造になっていないと、遷移に失敗するため注意
class Routes {
  static const String login = "/";
  static const String studentMain = "/student";
  static const String studentLessons = "/student/lessons";
  static const String studentTools = "/student/lessons/tools";
  static const String studentReading = "/student/lessons/tools/reading";
  static const String teacherMain = "/teacher";
  static const String teacherLessons = "/teacher/lessons";
  static const String teacherTools = "/teacher/lessons/tools";
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
  static const String activity = "/activity";
}

// 画面遷移状況を保持するキー
// 戻るボタンを押された時にどこに戻るべきか、などの情報が保持されている
final rootNavigatorKey = GlobalKey<NavigatorState>();

// personプロバイダーからユーザーの状態を持ってくるのが不健全に感じたため
// 別途auth.state.user監視用プロバイダーを用意
final roleProvider = FutureProvider<String>((ref) async {
  final authState = ref.watch(authStateProvider);
  final user = authState.value;
  if (user == null) return "";
  final token = await user.getIdTokenResult();
  return token.claims?["role"] ?? "";
});

///　ルータークラス
@riverpod
class Router extends _$Router {
  @override
  GoRouter build() {
    // ログイン状態に応じて、自動で画面遷移
    // firebase側でログイン状態を保持しておいてくれる
    final authState = ref.watch(authStateProvider);

    // 画面乗っ取りを常に監視
    // final hackState = ref.watch(hackedProvider);

    // personプロバイダーから情報を得ずに、authから情報を取ってくるように変更
    final role = ref.watch(roleProvider);

    // ダミーモード用
    final dummy = ref.watch(dummyModeProvider);

    // 実際の画面遷移構成
    return GoRouter(
      initialLocation: Routes.login,

      // 画面遷移を保持しておくのに使う。
      navigatorKey: rootNavigatorKey,

      // 画面遷移時、もしくはref.watchしている値の変化時に起動する
      redirect: (context, state) {
        return authState.when(
          data: (user) {
            final isLoggingIn = state.fullPath == Routes.login;

            // ユーザーが未ログインの場合
            if (user == null) {
              return isLoggingIn ? null : Routes.login;
            }

            // ユーザーがログイン済みの場合
            if (isLoggingIn) {
              if (role.value == "teacher") {
                return Routes.teacherMain;
              } else if (role.value == "student") {
                return Routes.studentMain;
              }
            }

            return null;
          },
          loading: () => null,
          error: (_, __) => Routes.login,
        );
      },

      // 実際に遷移するページをここに並べる
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => LoginPage(),
        ),

        // // ダミー用の分岐
        // if (dummy) dummyBranch,

        // 先生用のbottomBarを含めた分岐
        if (role.value == "teacher") teacherBranch,

        // 生徒用のbottomBarを含めた分岐
        if (role.value == "student") studentBranch,

        // 画面乗っ取り用のルート。後ほど変わる予定
        GoRoute(
          path: "/dr001",
          builder: (context, state) => DisplayResult(),
        ),
      ],
      debugLogDiagnostics: false,
    );
  }
}
