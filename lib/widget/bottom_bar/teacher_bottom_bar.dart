import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'bottom_bar_widget.dart';

class TeacherBottomBar extends HookConsumerWidget {
  const TeacherBottomBar({
    super.key,
    required this.navigationShell,
    this.name,
  });

  final String? name;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // animation controllerが入ったリストを作成
    final controllers = useState<List<AnimationController>>(
      List.generate(
        3,
        (_) => useAnimationController(
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );

    final selectedIndex = useState<int>(1);

    // 初回描画時にアニメーションを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final controller in controllers.value) {
        controller.forward();
      }
    });

    return Scaffold(
      body: navigationShell,
      floatingActionButton: null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: [
          RottieNavigationDestination(
            label: 'プロフィール',
            iconPath: 'assets/profile.json',
            animationController: controllers.value[0],
          ),
          RottieNavigationDestination(
            label: 'ホーム',
            iconPath: 'assets/home.json',
            animationController: controllers.value[1],
          ),
          ActivityLottieNavigationDestination(
            label: '通知',
            iconPath: 'assets/activity.json',
            animationController: controllers.value[2],
          ),
        ],
        onDestinationSelected: (index) {
          controllers.value[index].reset();
          selectedIndex.value = index;
          controllers.value[index].forward();

          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
