import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/dummy_base_page.dart';

class DummyProfilePage extends ConsumerWidget {
  const DummyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DummyBasePage(
      pageTitle: "ダミープロフィール",
      body: Center(
        child: Text("個人情報ページ(ダミー)"),
      ),
    );
  }
}
