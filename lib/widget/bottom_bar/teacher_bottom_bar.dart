import 'package:code/widget/bottom_bar/status_during.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// import '../../data/firebase/during_stream.dart';
import '../../data/person/person.dart';
// import '../floating/floating_record_button.dart';
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
    // final during = ref.watch(duringStreamProvider);
    final user = useState<Person>(Person.isBlank());
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

    void getUser() async {
      user.value = await ref.watch(personStatusProvider.future);
    }

    // 画面の真ん中を初期値にする
    final size = MediaQuery.of(context).size;

    final posX = useState(size.width / 2 - 350 / 2);
    final posY = useState(size.height - 70);

    useEffect(() {
      getUser();
      return null;
    }, []);

    return Scaffold(
        body: navigationShell,
        floatingActionButton: Stack(children: [
          Positioned(
            left: posX.value,
            top: posY.value,
            child: GestureDetector(
              onPanUpdate: (details) {
                posX.value += details.delta.dx;
                posY.value += details.delta.dy;
              },
              child: TeacherStatusMiniBottombar(teacher: user.value.name),
            ),
          ),
        ]),
        bottomNavigationBar: NavigationBar(
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
        ));
  }
}
