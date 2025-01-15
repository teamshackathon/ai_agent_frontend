import 'package:code/pages/lo001.dart';
import 'package:code/pages/sm001.dart';
import 'package:code/pages/tm001.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route.g.dart';

class Routes {
  static const String login = "/LO001";
  static const String teacherMain = "/TM001";
  static const String studentMain = "/SM001";
}

@riverpod
class Router extends _$Router {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: Routes.login,
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: Routes.teacherMain,
          builder: (context, state) => TeacherMain(),
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
