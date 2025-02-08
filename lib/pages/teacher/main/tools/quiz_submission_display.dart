import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/lesson/lesson.dart';
import '../../../../data/submission/submission.dart';
import '../../../student/main/tools/student_answer_check.dart';

class TeacherSubmissionsExpansionTile extends HookConsumerWidget {
  const TeacherSubmissionsExpansionTile({
    super.key,
    required this.title,
    required this.lesson,
    required this.submissions,
    required this.color,
  });

  final Widget title;
  final Lesson lesson;
  final List<Submission> submissions;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> list = [];

    for (var sub in submissions) {
      list.add(ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(height: 2),
            SizedBox(height: 14),
            Text(sub.name),
          ],
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "  ${sub.name}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 0.95,
                        heightFactor: 0.95,
                        child: StudentAnswerCheckDisplay(
                          lesson: lesson,
                          submission: sub,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ));
    }

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: color,
        collapsedBackgroundColor: color,
        title: title,
        children: list,
      ),
    );
  }
}
