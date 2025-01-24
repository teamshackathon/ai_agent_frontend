import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/dummy_base_page.dart';
import '../../widget/sakura_redial_menu/sakura_radial_menu.dart';

enum MenuOptions {
  unread,
  share,
  archive,
  delete,
  backup,
  copy,
}

class DummyProfilePage extends ConsumerWidget {

  DummyProfilePage({super.key});

  GlobalKey<RadialMenuState> _menuKey =GlobalKey<RadialMenuState>();

  final List<RadialMenuItem<MenuOptions>> items = <RadialMenuItem<MenuOptions>>[
    RadialMenuItem<MenuOptions>(
      key: UniqueKey(),
      child: const Icon(Icons.mark_email_unread_outlined),
      value: MenuOptions.unread,
      tooltip: 'Mark as unread',
      backgroundColor: Colors.blue,
      iconColor: Colors.white,
    ),
    RadialMenuItem<MenuOptions>(
      key: UniqueKey(),
      child: const Icon(Icons.share_outlined),
      value: MenuOptions.share,
      tooltip: 'Share',
      backgroundColor: Colors.green,
      iconColor: Colors.white,
    ),
    RadialMenuItem<MenuOptions>(
      key: UniqueKey(),
      child: const Icon(Icons.archive_outlined),
      value: MenuOptions.archive,
      tooltip: 'Archive',
      backgroundColor: Colors.orange,
      iconColor: Colors.white,
    ),
    RadialMenuItem<MenuOptions>(
      key: UniqueKey(),
      child: const Icon(Icons.delete_outline),
      value: MenuOptions.delete,
      tooltip: 'Delete',
      backgroundColor: Colors.red,
      iconColor: Colors.white,
    ),
    RadialMenuItem<MenuOptions>(
      key: UniqueKey(),
      child: const Icon(Icons.backup_outlined),
      value: MenuOptions.backup,
      tooltip: 'Backup',
      backgroundColor: Colors.purple,
      iconColor: Colors.white,
    ),
    RadialMenuItem<MenuOptions>(
      key: UniqueKey(),
      child: const Icon(Icons.copy_outlined),
      value: MenuOptions.copy,
      tooltip: 'Copy',
      backgroundColor: Colors.pink,
      iconColor: Colors.white,
    ),
  ];

  void _onItemSelected(MenuOptions value) {
    print(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DummyBasePage(
      pageTitle: "ダミープロフィール",
      body: Scaffold(
        body: RadialMenu(
            key: _menuKey,
            items: items,
            radius: 100.0,
            onSelected: _onItemSelected,
          ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.restore),
          onPressed: () => _menuKey.currentState?.reset(),
        ),
      ),
    );
  }
}
