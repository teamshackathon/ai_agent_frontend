import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/firebase/during_stream.dart';
import '../../data/person/person.dart';
import '../../pages/student/main/tools/student_quiz.dart';
import 'bottom_bar_widget.dart';

class StudentBottomBar extends HookConsumerWidget {
  const StudentBottomBar({
    super.key,
    required this.navigationShell,
    this.name,
  });

  final String? name;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final duringStream = ref.watch(duringStreamProvider);
    final student = ref.watch(personStatusProvider);
    final bool hack = duringStream.when(
      data: (snapshot) {
        final duringList = snapshot.docs;
        if (duringList.isEmpty) return false;
        final during = duringList.first.data();
        if (during["state"] != "test") return false;
        if (during["finish"].contains(student.value?.folderName ?? "-1")) {
          return false;
        }
        return true;
      },
      error: (_, __) => false,
      loading: () => false,
    );

    return Stack(children: [
      Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            destinations: [
              ProfileLottieNavigationDestination(
                label: 'プロフィール',
                iconPath: selectedIndex.value == 0
                    ? 'assets/profile_black.json'
                    : 'assets/profile.json',
                index: 0,
                selectedIndex: selectedIndex.value,
                animationController: controllers.value[0],
              ),
              RottieNavigationDestination(
                label: 'ホーム',
                iconPath: 'assets/home.json',
                index: 1,
                selectedIndex: selectedIndex.value,
                animationController: controllers.value[1],
              ),
              ActivityLottieNavigationDestination(
                label: '通知',
                iconPath: 'assets/activity.json',
                index: 2,
                selectedIndex: selectedIndex.value,
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
        ),
      ),
      if (hack)
        Scaffold(
          body: StudentQuiz(),
        ),
    ]);
  }
}
