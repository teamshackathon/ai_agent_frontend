import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/room/room.dart';
import '../../../route/route.dart';

const double _radiansPerDegree = math.pi / 180;
final double _startAngle = -90.0 * _radiansPerDegree;

class RadicalSakuraMenuEx extends HookConsumerWidget {
  const RadicalSakuraMenuEx({
    super.key,
    required this.rooms,
    this.radius = 100.0,
    this.menuAnimationDuration = const Duration(milliseconds: 1000),
    this.progressAnimationDuration = const Duration(milliseconds: 1000),
  });

  final List<Room> rooms;
  final double radius;
  final Duration menuAnimationDuration;
  final Duration progressAnimationDuration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuAnimeCtrl = useAnimationController(
      duration: menuAnimationDuration,
    );
    final tween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(menuAnimeCtrl);

    // initState、disposeをここ一つでやってくれる
    useEffect(() {
      // リスナーに関してはautoDisposeしてくれないので、
      // ここでリスナーを作成して、後から削除できるようにする
      void menuListener(AnimationStatus status) {
        if (status == AnimationStatus.completed) menuAnimeCtrl.reset();
      }

      // アニメーションの状態監視
      menuAnimeCtrl.addStatusListener(menuListener);

      // dispose処理
      return () {
        // リスナーを削除
        menuAnimeCtrl.removeStatusListener(menuListener);
      };
    }, []);

    final List<Widget> children = <Widget>[];

    for (final room in rooms) {
      children.add(LayoutId(
        id: '${_RadialMenuLayout.actionButton}${rooms.indexOf(room)}',
        child: AnimatedBuilder(
          animation: menuAnimeCtrl,
          builder: (context, child) => Opacity(
            opacity: tween.value,
            child: child,
          ),
          child: RadialSakuraMenuItemEx(
            subject: room.subject,
            angle: 2 * math.pi / rooms.length * rooms.indexOf(room),
            onPressed: () {
              // lessonsを取得できるように入れる
              GoRouter.of(context).push(Routes.studentLessons);
            },
          ),
        ),
      ));
    }

    return AnimatedBuilder(
      animation: menuAnimeCtrl,
      builder: (BuildContext context, Widget? child) {
        return CustomMultiChildLayout(
          delegate: _RadialMenuLayout(
            itemCount: rooms.length,
            radius: radius,
            calculateItemAngle: (index) {
              double itemSpacing = 360.0 / rooms.length;
              return _startAngle + index * itemSpacing * _radiansPerDegree;
            },
            controller: menuAnimeCtrl.view,
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
  final double Function(int) calculateItemAngle;

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
      calculateItemAngle != oldDelegate.calculateItemAngle ||
      controller != oldDelegate.controller ||
      _progress != oldDelegate._progress;
}

String _getSakuraSvgPath(String option) {
  switch (option) {
    case "japanese":
      return 'assets/sakura_japanese.svg';
    case "english":
      return 'assets/sakura_english.svg';
    case "social":
      return 'assets/sakura_social.svg';
    case "science":
      return 'assets/sakura_science.svg';
    case "math":
      return 'assets/sakura_math.svg';
    default:
      return "";
  }
}

class RadialSakuraMenuItemEx extends StatelessWidget {
  const RadialSakuraMenuItemEx({
    super.key,
    required this.subject,
    required this.angle,
    this.width = 150.0,
    this.height = 150.0,
    required this.onPressed,
  });

  final String subject;
  final double angle;
  final double width;
  final double height;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: angle,
        child: InkWell(
          onTap: onPressed,
          child: SvgPicture.asset(
            _getSakuraSvgPath(subject),
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
