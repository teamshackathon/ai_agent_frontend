import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/store_provider.dart';
import '../../../widget/base_page/base_page.dart';

class TeacherActivityPage extends ConsumerWidget {
  const TeacherActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hackRef = ref.watch(firestoreProvider).collection("2024").doc("2-1");
    final hack = ref.watch(hackingProvider);

    return BasePage(
      pageTitle: "教師アクティビティ",
      // // 画面に重なってボタンが配置される
      // // 一時的に生徒側の画面でも、テスト通知（自身にしか見えない）を送れる様になっている
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async => await sendNoticeToMyself(ref: ref),
      // ),
      body: Center(
        child: Column(
          children: [
            Text("画面ハッキング"),
            hack.when(
              data: (data) => Switch(
                value: data.data()?["hack"],
                onChanged: (value) async {
                  await hackRef.update({"hack": value});
                },
              ),
              error: (err, stack) => Text("読み込みエラー"),
              loading: () => CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
