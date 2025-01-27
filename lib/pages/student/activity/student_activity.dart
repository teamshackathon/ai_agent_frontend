import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/firebase/store_provider.dart';
import '../../firebase/firestore/notice/send_notice_to_myself.dart';
import '../../widget/base_page/base_page.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notices = ref.watch(noticesProvider);

    return BasePage(
      pageTitle: "アクティビティ",
      // 画面に重なってボタンが配置される
      // 一時的に生徒側の画面でも、テスト通知（自身にしか見えない）を送れる様になっている
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await sendNoticeToMyself(ref: ref),
      ),
      body: notices.when(
        // データを受け取れたときの処理
        data: (data) {
          return ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              final notice = data.docs[index].data();
              return InkWell(
                onTap: () async {
                  // タップすると既読に更新
                  // notice自身がfirestore上の位置へのPathを持ち続けているため
                  // updateを使用するだけで情報を更新できる
                  await notice.reference.update({"read": true});
                },
                child: Card(
                  child: Column(
                    children: [
                      Text(notice.read ? "既読" : "未読"),
                      Text(notice.title),
                      Text(notice.text),
                      Text(notice.publisher),
                      Text(notice.timeStamp.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        },
        // エラー時の表示
        error: (_, __) => const Center(
          child: Text("読み込み失敗"),
        ),
        // 読込中の表示
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
