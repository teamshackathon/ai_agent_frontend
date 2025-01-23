import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class StudentBottomBar extends StatefulWidget {
  const StudentBottomBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  _StudentBottomBarState createState() => _StudentBottomBarState();
}

class _StudentBottomBarState extends State<StudentBottomBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0; // 現在選択されているインデックス
  late List<AnimationController> _controllers; // late で初期化を遅らせる

  @override
  void initState() {
    super.initState();

    // 必ず navigationShell のタブ数に合わせたコントローラを初期化
    _controllers = List.generate(
      3, // タブの数
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500), // アニメーションの時間
      ),
    );
  }

  @override
  void dispose() {
    // AnimationController を解放
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 背景色
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // 桜色の影
              blurRadius: 15, // ぼかし半径
              offset: const Offset(0, -5), // 少し上に浮かせる影
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          destinations: [
            _buildLottieNavigationDestination(
              label: 'プロフィール',
              iconPath: 'assets/profile.json',
              index: 0,
            ),
            _buildLottieNavigationDestination(
              label: 'ホーム',
              iconPath: 'assets/home.json',
              index: 1,
            ),
            _buildLottieNavigationDestination(
              label: '通知',
              iconPath: 'assets/activity.json',
              index: 2,
              width: 30,
              height: 30, // 通知アイコンは大きめに
            ),
          ],
          onDestinationSelected: (index) {
            // アニメーションの更新
            setState(() {
              _controllers[_selectedIndex].reset(); // 現在選択されているアイコンをリセット
              _selectedIndex = index; // 新しいインデックスを設定
              _controllers[_selectedIndex].forward(); // 新しいインデックスでアニメーションを再生
            });

            widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            );
          },
        ),
      ),
    );
  }

  /// Lottieアニメーション付きのNavigationDestinationを構築
  NavigationDestination _buildLottieNavigationDestination({
    required String label,
    required String iconPath,
    required int index,
    double width = 30,
    double height = 30,
  }) {
    return NavigationDestination(
      label: label,
      icon: Container(
        child: Lottie.asset(
          iconPath,
          controller: _controllers[index], // 対応するコントローラを指定
          onLoaded: (composition) {
            // LottieComposition の時間を AnimationController に反映
            _controllers[index].duration = composition.duration;
          },
          width: width,
          height: height,
          repeat: false, // アニメーションを一度だけ再生
        ),
      ),
    );
  }
}
