import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firebase/submission_stream.dart';
import '../../pages/student/main/tools/student_homework.dart';
import '../utils/sakura_progress_indicator.dart';

class TeacherHomeworkTabBarView extends HookConsumerWidget {
  const TeacherHomeworkTabBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(submissionStreamProvider);

    return results.when(
      data: (snapshot) {
        final submissions = snapshot.docs;
        final List<Widget> list = [];

        for (var sub in submissions) {
          if (sub.data().homeworkResults.isNotEmpty) {
            list.add(ListTile(
              title: Text(sub.data().name, style: TextStyle(fontSize: 20)),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
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
                                "  ${sub.data().name}",
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
                              child: StudentHomeworkCheck(
                                submission: sub.data(),
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
        }
        if (list.isEmpty) {
          return const Center(child: Text("提出された宿題はありません"));
        }
        return ListView(children: list);
      },
      // エラー時の表示
      error: (_, __) => const Text("読み込み失敗"),
      // 読込中の表示
      loading: () => const SakuraProgressIndicator(),
    );
  }
}
