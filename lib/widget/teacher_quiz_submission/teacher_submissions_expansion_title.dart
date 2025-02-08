import 'package:code/data/submission/submission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/lesson/lesson.dart';
import '../../pages/student/main/tools/student_answer_check.dart';

final _checkKey = GlobalKey<NavigatorState>();

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
    final tabController = useTabController(initialLength: 3);
    final List<Widget> list = [];

    final checkRoute = GoRouter(
      routes: [
        GoRoute(
          path: "/",
        ),
        GoRoute(
          path: "/answer",
        )
      ],
    );

    for (var sub in submissions) {
      list.add(ListTile(
        title: Text(sub.name),
        onTap: () {
          // Navigator.of(context).push();
        },
      ));
    }

    return ExpansionTile(
      title: Text(title),
    );
  }
}
