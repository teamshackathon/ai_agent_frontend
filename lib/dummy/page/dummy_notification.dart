import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/base_page/base_page.dart';

class DummyNotificationPage extends ConsumerWidget {
  const DummyNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      pageTitle: "ダミー通知一覧",
      body: Center(
        child: Text("通知ページ(ダミー)"),
      ),
    );
  }
}
