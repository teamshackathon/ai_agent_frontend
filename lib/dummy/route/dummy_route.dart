// // BottomBarでページ遷移する用のダミーデータ
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import '../page/dummy_main.dart';
// import '../page/dummy_notification.dart';
// import '../page/dummy_profile.dart';
// import '../widget/dummy_bottom_bar.dart';
//
// class DummyRoutes {
//   static const String main = "/dummyMain";
//   static const String notification = "/dummyNotification";
//   static const String profile = "/dummyProfile";
// }
//
// // 各分岐の画面遷移を保持しておくのに使う。各ブランチに一つ
// final _dummyProfileKey = GlobalKey<NavigatorState>(debugLabel: 'dummyProfile');
// final _dummyMainKey = GlobalKey<NavigatorState>(debugLabel: 'dummyMain');
// final _dummyNotificationKey =
//     GlobalKey<NavigatorState>(debugLabel: 'dummyNotification');
//
// // BottomNavigationBarみたいにルートをぶった切って遷移する実装が欲しい場合、
// // ShellRouteを用いて、branchごとにそれぞれのページの遷移状態を保持しておける
// final dummyBranch = StatefulShellRoute.indexedStack(
//   // 生徒用BottomBar呼び出し
//   builder: (context, state, navigationShell) =>
//       DummyBottomBar(navigationShell: navigationShell),
//
//   // 生徒用画面はここに追加していく
//   branches: [
//     // プロフィール画面の分岐
//     StatefulShellBranch(
//       navigatorKey: _dummyProfileKey,
//       routes: [
//         GoRoute(
//           path: DummyRoutes.profile,
//           builder: (context, state) => DummyProfilePage(),
//         ),
//       ],
//     ),
//
//     // 生徒メイン画面の分岐
//     StatefulShellBranch(
//       navigatorKey: _dummyMainKey,
//       routes: [
//         GoRoute(
//           path: DummyRoutes.main,
//           builder: (context, state) => DummyMain(),
//         ),
//       ],
//     ),
//
//     // 通知画面の分岐
//     StatefulShellBranch(
//       navigatorKey: _dummyNotificationKey,
//       routes: [
//         GoRoute(
//           path: DummyRoutes.notification,
//           builder: (context, state) => DummyNotificationPage(),
//         ),
//       ],
//     ),
//   ],
// );
