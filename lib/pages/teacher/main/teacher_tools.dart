import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/firebase/storage/get_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

/// hotreloadの際は一度mainに帰って
class TeacherTools extends ConsumerWidget {
  const TeacherTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySize = MediaQuery.of(context).size;

    return BasePage(
      pageTitle: "教師機能選択",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  await getText(ref: ref);
                  if (context.mounted) {
                    GoRouter.of(context).push(Routes.studentReading);
                  }
                },
                child: Card(
                  child: Column(
                    children: [
                      Text(""),
                      Text("教科書を見る"),
                      Text(""),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  child: Column(
                    children: [
                      Text(""),
                      Text("小テストの確認"),
                      Text(""),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  child: Column(
                    children: [
                      Text(""),
                      Text("宿題"),
                      Text(""),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}