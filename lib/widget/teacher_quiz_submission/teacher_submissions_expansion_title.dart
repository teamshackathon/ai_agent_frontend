import 'package:code/data/submission/submission.dart';
import 'package:flutter/material.dart';

import '../../data/lesson/lesson.dart';

class TeacherTestExpansionTitle extends StatelessWidget {
  const TeacherTestExpansionTitle({
    super.key,
    required this.title,
    required this.lesson,
    required this.submissions,
  });

  final String title;
  final Lesson lesson;
  final List<Submission> submissions;
  final String 

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
    );
  }
}
