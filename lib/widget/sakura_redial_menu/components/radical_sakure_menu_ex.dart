// import 'dart:math' as Math;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// const double _radiansPerDegree = Math.pi / 180;
// final double _startAngle = -90.0 * _radiansPerDegree;
//
// class RadicalSakuraMenuEx extends HookConsumerWidget {
//   const RadicalSakuraMenuEx({
//     super.key,
//     required this.items,
//     required this.onSelected,
//     this.radius = 100.0,
//     this.menuAnimationDuration = const Duration(milliseconds: 1000),
//     this.progressAnimationDuration = const Duration(milliseconds: 1000),
//   });
//
//   final List<Widget> items;
//   final ValueChanged onSelected;
//   final double radius;
//   final Duration menuAnimationDuration;
//   final Duration progressAnimationDuration;
//
//   double calculateItemAngle(int index) {
//     double itemSpacing = 360.0 / items.length;
//     return _startAngle + index * itemSpacing * _radiansPerDegree;
//   }
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final menuAnimeCtrl = useAnimationController(
//       duration: menuAnimationDuration,
//     );
//     final tween = Tween(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(menuAnimeCtrl);
//
//     // initState、disposeをここ一つでやってくれる
//     useEffect(() {
//       // リスナーに関してはautoDisposeしてくれないので、
//       // ここでリスナーを作成して、後から削除できるようにする
//       void menuListener(AnimationStatus status) {
//         if (status == AnimationStatus.completed) menuAnimeCtrl.reset();
//       }
//
//       // アニメーションの状態監視
//       menuAnimeCtrl.addStatusListener(menuListener);
//
//       // dispose処理
//       return () {
//         // リスナーを削除
//         menuAnimeCtrl.removeStatusListener(menuListener);
//       };
//     }, []);
//
//     final List<Widget> children = <Widget>[];
//
//     for (final item in items) {
//       children.add(LayoutId(
//         id: '${_RadialMenuLayout.actionButton}${items.indexOf(item)}',
//         child: AnimatedBuilder(
//           animation: menuAnimeCtrl,
//           builder: (context, child) => Opacity(
//             opacity: tween.value,
//             child: child,
//           ),
//           child: item,
//         ),
//       ));
//     }
//
//     return AnimatedBuilder(
//       animation: menuAnimeCtrl,
//       builder: (BuildContext context, Widget? child) {
//         return CustomMultiChildLayout(
//           delegate: _RadialMenuLayout(
//             itemCount: items.length,
//             radius: radius,
//             calculateItemAngle: calculateItemAngle,
//             controller: menuAnimeCtrl.view,
//           ),
//           children: children,
//         );
//       },
//     );
//   }
// }