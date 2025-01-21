import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widget/base_page/base_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      pageTitle: "あなたの情報",
      body: Center(
        child: Text("個人情報ページ"),
      ),
    );
  }
}
