import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudentBottomBar extends StatelessWidget {
  const StudentBottomBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(
            label: 'プロフィール',
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
          ),
          NavigationDestination(
            label: 'ホーム',
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            label: '通知',
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
          ),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
