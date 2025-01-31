import 'package:code/data/firebase/store_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RottieNavigationDestination extends HookConsumerWidget {
  const RottieNavigationDestination({
    super.key,
    required this.label,
    required this.iconPath,
    required this.animationController,
    this.width = 30,
    this.height = 30,
  });

  final String label;
  final String iconPath;
  final AnimationController animationController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDestination(
      label: label,
      icon: Container(
        child: Lottie.asset(
          iconPath,
          controller: animationController,
          onLoaded: (composition) {
            animationController.duration = composition.duration;
          },
          width: width,
          height: height,
          repeat: false,
        ),
      ),
    );
  }
}

class ActivityLottieNavigationDestination extends HookConsumerWidget {
  const ActivityLottieNavigationDestination({
    super.key,
    required this.label,
    required this.iconPath,
    required this.animationController,
    this.width = 30,
    this.height = 30,
  });

  final String label;
  final String iconPath;
  final AnimationController animationController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDestination(
      label: label,
      icon: ActivityContainerRottieIcon(
        iconPath: iconPath,
        controller: animationController,
        onLoaded: (composition) {
          animationController.duration = composition.duration;
        },
        width: width,
        height: height,
        repeat: false,
      ),
    );
  }
}

class ActivityContainerRottieIcon extends ConsumerWidget {
  const ActivityContainerRottieIcon({
    super.key,
    required this.iconPath,
    required this.controller,
    required this.onLoaded,
    required this.width,
    required this.height,
    required this.repeat,
  });

  final String iconPath;
  final AnimationController controller;
  final void Function(LottieComposition) onLoaded;
  final double width;
  final double height;
  final bool repeat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeStream = ref.watch(noticeGetProvider);

    return noticeStream.when(data: (snapshot) {
      final notices = snapshot.docs;
      final unreadNotices = notices.where((notice) => !notice.data().read);
      if (unreadNotices.isEmpty) {
        return Lottie.asset(
          iconPath,
          controller: controller, // 対応するコントローラを指定
          onLoaded: onLoaded,
          width: width,
          height: height,
          repeat: false,
        );
      } else {
        return Badge.count(
          count: unreadNotices.length,
          child: Lottie.asset(
            iconPath,
            controller: controller, // 対応するコントローラを指定
            onLoaded: onLoaded,
            width: width,
            height: height,
            repeat: false, // アニメーションを一度だけ再生
          ),
        );
      }
    }, error: (_, __) {
      return Lottie.asset(
        iconPath,
        controller: controller, // 対応するコントローラを指定
        onLoaded: onLoaded,
        width: width,
        height: height,
        repeat: false,
      );
    }, loading: () {
      return Lottie.asset(
        iconPath,
        controller: controller, // 対応するコントローラを指定
        onLoaded: onLoaded,
        width: width,
        height: height,
        repeat: false,
      );
    });
  }
}
