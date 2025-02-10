import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sakura/widget/utils/sakura_progress_indicator.dart';

import '../../data/lesson/lesson.dart';

class TeacherSummary extends HookConsumerWidget {
  const TeacherSummary({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = lesson.summary;

    return summary["markdown"] == null
        ? Center(child: SakuraProgressIndicator())
        : FractionallySizedBox(
            widthFactor: 0.95,
            heightFactor: 0.95,
            child: Markdown(data: summary["markdown"]),
          );
  }
}
