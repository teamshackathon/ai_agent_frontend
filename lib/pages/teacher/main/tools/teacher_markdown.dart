import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';

class TeacherMarkdown extends HookConsumerWidget {
  const TeacherMarkdown({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdown = lesson.summary.markdown;

    return FractionallySizedBox(
      widthFactor: 0.95,
      heightFactor: 0.95,
      child: Markdown(data: markdown),
    );
  }
}
