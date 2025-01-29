import 'dart:math' as Math;

import 'package:code/widget/sakura_redial_menu/components/radial_sakura_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const double _radiansPerDegree = Math.pi / 180;
final double _startAngle = -90.0 * _radiansPerDegree;

typedef double ItemAngleCalculator(int index);

class RadialSakuraMenu extends StatefulWidget {
  const RadialSakuraMenu({
    required Key key,
    required this.items,
    required this.onSelected,
    this.radius = 100.0,
    this.menuAnimationDuration = const Duration(milliseconds: 1000),
    this.progressAnimationDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  final List<RadialSakuraMenuItem> items;
  final ValueChanged onSelected;
  final double radius;
  final Duration menuAnimationDuration;
  final Duration progressAnimationDuration;

  @override
  RadialSakuraMenuState createState() => RadialSakuraMenuState();
}

class RadialSakuraMenuState extends State<RadialSakuraMenu>
    with TickerProviderStateMixin {
  AnimationController? _menuAnimationController;
  AnimationController? _progressAnimationController;
  int? _activeItemIndex;

  double calculateItemAngle(int index) {
    double itemSpacing = 360.0 / widget.items.length;
    return _startAngle + index * itemSpacing * _radiansPerDegree;
  }

  @override
  void initState() {
    super.initState();
    _menuAnimationController = AnimationController(
      duration: widget.menuAnimationDuration,
      vsync: this,
    );
    _progressAnimationController = AnimationController(
      duration: widget.progressAnimationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _menuAnimationController?.dispose();
    _progressAnimationController?.dispose();
    super.dispose();
  }

  void openMenu() {
    _menuAnimationController?.forward();
  }

  void closeMenu() {
    _menuAnimationController?.reverse();
  }

  bool get isOpen =>
      _menuAnimationController!.status == AnimationStatus.completed;

  /// Resets the menu to its initial (closed) state.
  void reset() {
    _menuAnimationController?.reset();
    _progressAnimationController?.reverse();
    setState(() {
      _activeItemIndex = null;
    });
  }

  Widget _buildActionButton(int index) {
    final RadialSakuraMenuItem item = widget.items[index];
    return LayoutId(
      id: '${_RadialMenuLayout.actionButton}$index',
      child: AnimatedBuilder(
        animation: _menuAnimationController!,
        builder: (context, child) {
          return Opacity(
            opacity: CurvedAnimation(
              parent: _menuAnimationController!,
              curve: Interval(0.0, 1.0, curve: Curves.easeInOut),
            ).value,
            child: child,
          );
        },
        child: item,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.items.length; i++) {
      if (_activeItemIndex != i) {
        children.add(_buildActionButton(i));
      }
    }

    return AnimatedBuilder(
      animation: _menuAnimationController!,
      builder: (BuildContext context, Widget? child) {
        return CustomMultiChildLayout(
          delegate: _RadialMenuLayout(
            itemCount: widget.items.length,
            radius: widget.radius,
            calculateItemAngle: calculateItemAngle,
            controller: _menuAnimationController!.view,
          ),
          children: children,
        );
      },
    );
  }
}

class _RadialMenuLayout extends MultiChildLayoutDelegate {
  static const String menuButton = 'menuButton';
  static const String actionButton = 'actionButton';
  static const String activeAction = 'activeAction';

  final int itemCount;
  final double radius;
  final ItemAngleCalculator calculateItemAngle;

  final Animation<double> controller;

  final Animation<double> _progress;

  _RadialMenuLayout({
    required this.itemCount,
    required this.radius,
    required this.calculateItemAngle,
    required this.controller,
  }) : _progress = Tween<double>(begin: 0.0, end: radius).animate(
            CurvedAnimation(curve: Curves.elasticOut, parent: controller));

  late Offset center;

  @override
  void performLayout(Size size) {
    center = Offset(size.width / 2, size.height / 2);

    if (hasChild(menuButton)) {
      Size menuButtonSize;
      menuButtonSize = layoutChild(menuButton, BoxConstraints.loose(size));

      // place the menubutton in the center
      positionChild(
        menuButton,
        Offset(
          center.dx - menuButtonSize.width / 2,
          center.dy - menuButtonSize.height / 2,
        ),
      );
    }

    for (int i = 0; i < itemCount; i++) {
      final String actionButtonId = '$actionButton$i';
      final String actionArcId = '$activeAction$i';
      if (hasChild(actionArcId)) {
        final Size arcSize = layoutChild(
          actionArcId,
          BoxConstraints.expand(
            width: _progress.value * 2,
            height: _progress.value * 2,
          ),
        );

        positionChild(
          actionArcId,
          Offset(
            center.dx - arcSize.width / 2,
            center.dy - arcSize.height / 2,
          ),
        );

        // opacity
      }

      if (hasChild(actionButtonId)) {
        final Size buttonSize =
            layoutChild(actionButtonId, BoxConstraints.loose(size));

        final double itemAngle = calculateItemAngle(i);

        positionChild(
          actionButtonId,
          Offset(
            (center.dx - buttonSize.width / 2) +
                (_progress.value) * Math.cos(itemAngle),
            (center.dy - buttonSize.height / 2) +
                (_progress.value) * Math.sin(itemAngle),
          ),
        );
      }
    }
  }

  @override
  bool shouldRelayout(_RadialMenuLayout oldDelegate) =>
      itemCount != oldDelegate.itemCount ||
      radius != oldDelegate.radius ||
      calculateItemAngle != oldDelegate.calculateItemAngle ||
      controller != oldDelegate.controller ||
      _progress != oldDelegate._progress;
}
