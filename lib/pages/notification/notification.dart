import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widget/base_page/base_page.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      pageTitle: "通知一覧",
      body: Center(
        child: Text("通知ページ"),
      ),
    );
  }
}