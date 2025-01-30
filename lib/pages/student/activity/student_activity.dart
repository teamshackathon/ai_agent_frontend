import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/firebase/store_provider.dart';
import '../../../firebase/firestore/notice/send_notice_to_myself.dart';
import '../../../widget/base_page/base_page.dart';
import '../../../widget/activity/activity_list_item.dart';
import '../../../widget/activity/activity_filter_button.dart';

class StudentActivityPage extends HookConsumerWidget {
  const StudentActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeStream = ref.watch(noticeGetProvider);

    final filter = useState("all");

    return BasePage(
      pageTitle: "あなたのアクティビティ",
      // 画面に重なってボタンが配置される
      // 一時的に生徒側の画面でも、テスト通知（自身にしか見えない）を送れる様になっている
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await sendNoticeToMyself(ref: ref),
      ),
      body: noticeStream.when(
        // データを受け取れたときの処理
        data: (snapshot) {
          final notices = snapshot.docs;
          // noticesの配列をリバースする
          notices
              .sort((a, b) => b.data().timeStamp.compareTo(a.data().timeStamp));

          // filterの値によって表示する通知を変える
          if (filter.value == "unread") {
            notices.removeWhere((notice) => notice.data().read);
          } else if (filter.value == "teacher") {
            notices
                .removeWhere((notice) => notice.data().publisher != "teacher");
          } else if (filter.value == "manabiya-ai") {
            notices.removeWhere(
                (notice) => notice.data().publisher != "Manabiya AI");
          } else if (filter.value == "system") {
            notices.removeWhere((notice) => notice.data().publisher != "Admin");
          }

          if (notices.isEmpty) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Flex(
                        direction: Axis.horizontal,
                        children: [
                          ActivitySelectableFilterButton(
                            selected: filter.value == "all",
                            child: Text('すべて'),
                            onPressed: () => {filter.value = "all"},
                          ),
                          ActivitySelectableFilterButton(
                            selected: filter.value == "unread",
                            child: Text('未読のみ'),
                            onPressed: () => {filter.value = "unread"},
                          ),
                          ActivitySelectableFilterButton(
                            selected: filter.value == "teacher",
                            child: Text('先生からの通知'),
                            onPressed: () => {filter.value = "teacher"},
                          ),
                          ActivitySelectableFilterButton(
                            selected: filter.value == "manabiya-ai",
                            child: Text('Manabiya AIからの通知'),
                            onPressed: () => {filter.value = "manabiya-ai"},
                          ),
                          ActivitySelectableFilterButton(
                            selected: filter.value == "system",
                            child: Text('システムからの通知'),
                            onPressed: () => {filter.value = "system"},
                          ),
                        ],
                      )),
                ),
                Expanded(child: Center(child: Text("通知がありません")))
              ],
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        ActivitySelectableFilterButton(
                          selected: filter.value == "all",
                          child: Text('すべて'),
                          onPressed: () => {filter.value = "all"},
                        ),
                        ActivitySelectableFilterButton(
                          selected: filter.value == "unread",
                          child: Text('未読のみ'),
                          onPressed: () => {filter.value = "unread"},
                        ),
                        ActivitySelectableFilterButton(
                          selected: filter.value == "teacher",
                          child: Text('先生からの通知'),
                          onPressed: () => {filter.value = "teacher"},
                        ),
                        ActivitySelectableFilterButton(
                          selected: filter.value == "manabiya-ai",
                          child: Text('Manabiya AIからの通知'),
                          onPressed: () => {filter.value = "manabiya-ai"},
                        ),
                        ActivitySelectableFilterButton(
                          selected: filter.value == "system",
                          child: Text('システムからの通知'),
                          onPressed: () => {filter.value = "system"},
                        ),
                      ],
                    )),
              ),
              Expanded(
                  child: ListView.separated(
                itemCount: notices.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final notice = notices[index].data();
                  return InkWell(
                    onTap: () async {
                      // タップすると既読に更新
                      // notice自身がfirestore上の位置へのPathを持ち続けているため
                      // updateを使用するだけで情報を更新できる
                      await notice.reference.update({"read": true});
                    },
                    child: ActivityListItem(
                      read: notice.read,
                      title: notice.title,
                      text: notice.text,
                      publisher: notice.publisher,
                      timeStamp: notice.timeStamp,
                      onUnread: () async {
                        // 未読にする処理
                        await notice.reference.update({"read": false});
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ))
            ],
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
