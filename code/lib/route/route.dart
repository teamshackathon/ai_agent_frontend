import 'package:code/pages/LO001.dart';
import 'package:code/pages/SM001.dart';
import 'package:code/pages/TM001.dart';
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
        GoRoute(path: "/mq001", builder: (context, state) => MakeQuizzes()),
        GoRoute(path: "/mq002", builder: (context, state) => EditQuizzes()),
        GoRoute(path: "/ss001", builder: (context, state) => SubmitStatus()),
        GoRoute(path: "/ss002", builder: (context, state) => PreviewAnswer()),
        GoRoute(path: "/ss003", builder: (context, state) => EditAnswer()),
        GoRoute(path: "/et001", builder: (context, state) => EditText()),
        GoRoute(path: "/tq001", builder: (context, state) => TakeQuizzes()),
        GoRoute(path: "/dr001", builder: (context, state) => DisplayResult()),
        GoRoute(path: "/dr002", builder: (context, state) => RequestFix()),
      ],
      debugLogDiagnostics: true,
    );
  }
}
