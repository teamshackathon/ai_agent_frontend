import 'package:code/firebase/storage/get_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../route/route.dart';
import '../../widget/base_page/base_page.dart';

/// hotreloadの際は一度mainに帰って
class StudentTools extends ConsumerWidget {
  const StudentTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySize = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "生徒機能選択",

      // childrenを縦に並べるWidget
      body: Center(
        child: InkWell(
          onTap: () async {
            await getText(ref: ref);
            // PDF読み込みは一回諦め
            // GoRouter.of(context).push(Routes.studentReading);
          },
          child: Card(
            child: SizedBox(
              width: displaySize.width * 0.8,
              height: displaySize.width * 0.2,
              child: Center(child: Text("教科書を見る")),
            ),
          ),
        ),
      ),
    );
  }
}
