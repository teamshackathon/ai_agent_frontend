import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;

import '../widget/dummy_base_page.dart';
import '../../widget/sakura_redial_menu/radial_menu.dart';

class DummyMain extends ConsumerWidget {
  DummyMain({super.key});

  final GlobalKey<RadialSakuraMenuState> _menuKey =
      GlobalKey<RadialSakuraMenuState>();

  // 基準
  final double base = 120.0;

  final List<RadialSakuraMenuItem> items = <RadialSakuraMenuItem>[
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.japanese,
      angle: 0.0,
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.english,
      angle: 2 * math.pi / 5 * 1,
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.social,
      angle: 2 * math.pi / 5 * 2,
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.science,
      angle: 2 * math.pi / 5 * 3,
    ),
    RadialSakuraMenuItem(
      key: UniqueKey(),
      value: MenuOptions.math,
      angle: 2 * math.pi / 5 * 4,
    ),
  ];

  void _onItemSelected(dynamic value) {
    print(value);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return DummyBasePage(
      pageTitle: "ダミープロフィール",
      body: Scaffold(
        body: RadialSakuraMenu(
          key: _menuKey,
          items: items,
          radius: 100.0,
          onSelected: _onItemSelected,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.restore),
          onPressed: () {
            if (_menuKey.currentState != null) {
              if (_menuKey.currentState!.isOpen) {
                _menuKey.currentState?.closeMenu();
              } else {
                _menuKey.currentState?.openMenu();
              }
            }
          },
        ),
      ),
    );
  }
}
