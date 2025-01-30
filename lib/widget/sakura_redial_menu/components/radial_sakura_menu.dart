import 'dart:math' as math;

import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _radiansPerDegree = math.pi / 180;

typedef double ItemAngleCalculator(int index);

class RadialSakuraMenu extends HookConsumerWidget {
  const RadialSakuraMenu({
    super.key,
    required this.items,
    this.radius = 100.0,
    this.menuAnimationDuration = const Duration(milliseconds: 1000),
  });

  final List<RadialSakuraMenuItem> items;
  final double radius;
  final Duration menuAnimationDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAnimationController = useAnimationController(
      duration: menuAnimationDuration,
    );

    final startAngle = -90.0 * _radiansPerDegree;

    final List<Widget> children = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      children.add(_buildActionButton(i, menuAnimationController));
    }

    // 初回描画時にアニメーションを開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      menuAnimationController.forward();
    });

    // 再描画時にアニメーションを開始

    return Expanded(
      child: AnimatedBuilder(
          animation: menuAnimationController,
          builder: (context, child) {
            return CustomMultiChildLayout(
              delegate: _RadialMenuLayout(
                itemCount: items.length,
                radius: radius,
                startAngle: startAngle,
                controller: menuAnimationController,
              ),
              children: children,
            );
          }),
    );
  }

  Widget _buildActionButton(int index, AnimationController controller) {
    final RadialSakuraMenuItem item = items[index];
    return LayoutId(
      id: '${_RadialMenuLayout.actionButton}$index',
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Opacity(
                opacity: CurvedAnimation(
                  parent: controller,
                  curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
                ).value,
                child: child);
          },
          child: item),
    );
  }
}

class _RadialMenuLayout extends MultiChildLayoutDelegate {
  static const String menuButton = 'menuButton';
  static const String actionButton = 'actionButton';

  final int itemCount;
  final double radius;

  final double startAngle;

  final Animation<double> controller;

  final Animation<double> _progress;

  _RadialMenuLayout({
    required this.itemCount,
    required this.radius,
    required this.startAngle,
    required this.controller,
  }) : _progress = Tween<double>(begin: 0.0, end: radius).animate(
            CurvedAnimation(curve: Curves.elasticOut, parent: controller));

  late Offset center;

  double calculateItemAngle(int index) {
    double itemSpacing = 360.0 / itemCount;
    return startAngle + index * itemSpacing * _radiansPerDegree;
  }

  @override
  void performLayout(Size size) {
    center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < itemCount; i++) {
      final String actionButtonId = '$actionButton$i';

      if (hasChild(actionButtonId)) {
        final Size buttonSize =
            layoutChild(actionButtonId, BoxConstraints.loose(size));

        final double itemAngle = calculateItemAngle(i);
        positionChild(
          actionButtonId,
          Offset(
            (center.dx - buttonSize.width / 2) +
                (_progress.value) * math.cos(itemAngle),
            (center.dy - buttonSize.height / 2) +
                (_progress.value) * math.sin(itemAngle),
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(_RadialMenuLayout oldDelegate) =>
      itemCount != oldDelegate.itemCount ||
      radius != oldDelegate.radius ||
      startAngle != oldDelegate.startAngle ||
      controller != oldDelegate.controller ||
      _progress != oldDelegate._progress;
}
