import 'package:code/pages/LO001.dart';
import 'package:code/pages/SM001.dart';
import 'package:code/pages/TM001.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'route.g.dart';

@riverpod
class Router extends _$Router {
  @override
  GoRouter build() {
    return GoRouter(
      initialLocation: "/LO001",
      redirect: (context, state) {
        return null;
      },
      routes: [
        GoRoute(path: "/LO001", builder: (context, state) => LoginPage()),
        GoRoute(path: "/TM001", builder: (context, state) => TeacherMain()),
        GoRoute(path: "/SM001", builder: (context, state) => StudentMain()),
      ],
      debugLogDiagnostics: true,
    );
  }
}
