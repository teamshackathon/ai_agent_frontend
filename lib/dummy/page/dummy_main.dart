import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/dummy_base_page.dart';

class DummyMain extends ConsumerWidget {
  const DummyMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DummyBasePage(
      pageTitle: "ダミーメイン",
      body: Center(
        child: Text("メインページ(ダミー)"),
      ),
    );
  }
}
