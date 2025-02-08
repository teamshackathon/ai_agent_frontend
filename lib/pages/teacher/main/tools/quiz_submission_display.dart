import 'package:code/data/submission/submission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/lesson/lesson.dart';
import '../../pages/student/main/tools/student_answer_check.dart';

final _checkKey = GlobalKey<NavigatorState>();

final _checkRoute = GoRouter(
  navigatorKey: _checkKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
    ),
    GoRoute(
      path: "/answer",
    )
  ],
);

class TeacherSubmissionsExpansionTitle extends HookConsumerWidget {
  const TeacherSubmissionsExpansionTitle({
    super.key,
    required this.title,
    required this.lesson,
    required this.submissions,
  });

  final String title;
  final Lesson lesson;
  final List<Submission> submissions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> list = [];
    final subState = useState<Submission>(Submission.isBlank());

    for (var sub in submissions) {
      list.add(ListTile(
        title: Text(sub.name),
        onTap: () {
          subState.value = sub;
        },
      ));
    }

    return ExpansionTile(
      title: Text(title),
    );
  }
}
