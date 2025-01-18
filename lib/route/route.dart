import 'package:code/firebase/provider/firebase_provider.dart';
import 'package:code/pages/login/login.dart';
import 'package:code/pages/student/student_main.dart';
import 'package:code/pages/teacher/teacher_main.dart';
import 'package:code/pages/dr001.dart';
import 'package:code/pages/dr002.dart';
import 'package:code/pages/et001.dart';
import 'package:code/pages/mq001.dart';
import 'package:code/pages/mq002.dart';
import 'package:code/pages/ss001.dart';
import 'package:code/pages/ss002.dart';
import 'package:code/pages/ss003.dart';
import 'package:code/pages/tq001.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route.g.dart';

/// ルート用ディレクトリ定数定義クラス

class Routes {
  static const String login = "/login";
  static const String teacherMain = "/teacher";
  static const String studentMain = "/student";
  static const String makeQuizzes = "/quiz";
  static const String editQuizzes = "/quiz/edit";
  static const String submitStatus = "/ss001";
  static const String previewAnswer = "/ss002";
  static const String editAnswer = "/ss003";
  static const String takeQuizzes = "/tq001";
  static const String editText = "/et001";
  static const String displayResult = "/dr001";
  static const String requestFix = "/dr002";
}

///　ルータークラス
@riverpod
class Router extends _$Router {
  @override
  GoRouter build() {
    // ログイン状態に応じて、自動で画面遷移
    // firebase側でログイン状態を保持しておいてくれるっぽい
    final authState = ref.watch(authStateProvider);
    String initialLocation = Routes.login;

    // authStateはStreamデータなので、whenDataで状態に応じた処理を書ける
    authState.whenData((user) {
      initialLocation = user != null ? Routes.teacherMain : Routes.login;
    });

    return GoRouter(
      initialLocation: initialLocation,
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: Routes.makeQuizzes,
          builder: (context, state) => MakeQuizzes(),
        ),
        GoRoute(
          path: Routes.editQuizzes,
          builder: (context, state) => EditQuizzes(),
        ),
        GoRoute(
          path: Routes.submitStatus,
          builder: (context, state) => SubmitStatus(),
        ),
        GoRoute(
          path: Routes.previewAnswer,
          builder: (context, state) => PreviewAnswer(),
        ),
        GoRoute(
          path: Routes.editAnswer,
          builder: (context, state) => EditAnswer(),
        ),
        GoRoute(
          path: Routes.editText,
          builder: (context, state) => EditText(),
        ),
        GoRoute(
          path: "/tq001",
          builder: (context, state) => TakeQuizzes(),
        ),
        GoRoute(
          path: "/dr001",
          builder: (context, state) => DisplayResult(),
        ),
        GoRoute(
          path: "/dr002",
          builder: (context, state) => RequestFix(),
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: Routes.teacherMain,
          builder: (context, state) => TeacherMain(),
          routes: [
            GoRoute(
              path: Routes.makeQuizzes,
              builder: (context, state) => MakeQuizzes(),
              routes: [
                GoRoute(
                  path: Routes.editQuizzes,
                  builder: (context, state) => EditQuizzes(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.studentMain,
          builder: (context, state) => StudentMain(),

        ),
      ],
      debugLogDiagnostics: false,
    );
  }
}
