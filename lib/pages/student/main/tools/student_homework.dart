import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';

class StudentHomework extends ConsumerWidget {
  const StudentHomework({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(child: Text("宿題"));
  }
}
