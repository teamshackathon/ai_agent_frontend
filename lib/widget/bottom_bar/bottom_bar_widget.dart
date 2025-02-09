import 'package:code/data/firebase/store_provider.dart';
import 'package:code/data/person/person.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RottieNavigationDestination extends HookConsumerWidget {
  const RottieNavigationDestination({
    super.key,
    required this.label,
    required this.iconPath,
    required this.index,
    required this.selectedIndex,
    required this.animationController,
    this.width = 30,
    this.height = 30,
  });

  final String label;
  final String iconPath;
  final int index;
  final int selectedIndex;
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
          delegates: LottieDelegates(
            values: [
              index == selectedIndex
                  ? ValueDelegate.color(
                      const ['**'],
                      value: Color(0xFF020b19),
                    )
                  : ValueDelegate.color(
                      const ['**'],
                      value: Colors.blueAccent,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileLottieNavigationDestination extends HookConsumerWidget {
  const ProfileLottieNavigationDestination({
    super.key,
    required this.label,
    required this.iconPath,
    required this.index,
    required this.selectedIndex,
    required this.animationController,
    this.width = 30,
    this.height = 30,
  });

  final String label;
  final String iconPath;
  final int index;
  final int selectedIndex;
  final AnimationController animationController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDestination(
      label: label,
      icon: ProfileContainerRottieIcon(
        iconPath: iconPath,
        index: index,
        selectedIndex: selectedIndex,
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

class ProfileContainerRottieIcon extends HookConsumerWidget {
  const ProfileContainerRottieIcon({
    super.key,
    required this.iconPath,
    required this.index,
    required this.selectedIndex,
    required this.controller,
    required this.onLoaded,
    required this.width,
    required this.height,
    required this.repeat,
  });

  final String iconPath;
  final int index;
  final int selectedIndex;
  final AnimationController controller;
  final void Function(LottieComposition) onLoaded;
  final double width;
  final double height;
  final bool repeat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(personStatusProvider.future);

    final userIconPathState = useState<String>("");

    Widget defaultIcon() {
      return Icon(
        Icons.person,
        color: index == selectedIndex
            ? Color(0xFF020b19)
            : const Color(0xFF448AFF),
        size: 25,
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset(
          iconPath,
          controller: controller,
          onLoaded: onLoaded,
          width: width,
          height: height,
          repeat: repeat,
          delegates: LottieDelegates(
            values: [
              index == selectedIndex
                  ? ValueDelegate.color(
                      const ['**'],
                      value: Color(0xFF020b19),
                    )
                  : ValueDelegate.color(
                      const ['**'],
                      value: Colors.blueAccent,
                    ),
            ],
          ),
        ),
        userIconPathState.value != ""
            ? CircleAvatar(
                radius: 12,
                backgroundImage: NetworkImage(userIconPathState.value),
              )
            : FutureBuilder(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text("エラーが発生しました");
                  } else {
                    // Logger().i(snapshot.data?.iconPath);
                    final userIconPath = snapshot.data?.iconPath ?? "";
                    // userIconPathはstoreageに保存されている画像のパス
                    final storage = FirebaseStorage.instance;
                    final pdf = storage.ref(userIconPath).getDownloadURL();
                    return userIconPath == ""
                        ? defaultIcon()
                        : FutureBuilder(
                            future: pdf,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return defaultIcon();
                              } else if (snapshot.hasError) {
                                return defaultIcon();
                              } else if (!snapshot.hasData) {
                                return defaultIcon();
                              } else {
                                userIconPathState.value = snapshot.data ?? "";
                                return CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data ?? ""),
                                  radius: 12.5,
                                );
                              }
                            },
                          );
                  }
                },
              ),
      ],
    );
  }
}

class ActivityLottieNavigationDestination extends HookConsumerWidget {
  const ActivityLottieNavigationDestination({
    super.key,
    required this.label,
    required this.iconPath,
    required this.index,
    required this.selectedIndex,
    required this.animationController,
    this.width = 30,
    this.height = 30,
  });

  final String label;
  final String iconPath;
  final int index;
  final int selectedIndex;
  final AnimationController animationController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationDestination(
      label: label,
      icon: ActivityContainerRottieIcon(
        iconPath: iconPath,
        index: index,
        selectedIndex: selectedIndex,
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
    required this.index,
    required this.selectedIndex,
    required this.controller,
    required this.onLoaded,
    required this.width,
    required this.height,
    required this.repeat,
  });

  final String iconPath;
  final int index;
  final int selectedIndex;
  final AnimationController controller;
  final void Function(LottieComposition) onLoaded;
  final double width;
  final double height;
  final bool repeat;

  Widget lottieIcon() {
    return Lottie.asset(iconPath,
        controller: controller, // 対応するコントローラを指定
        onLoaded: onLoaded,
        width: width,
        height: height,
        repeat: repeat,
        delegates: LottieDelegates(
          values: [
            index == selectedIndex
                ? ValueDelegate.color(
                    const ['**'],
                    value: Color(0xFF020b19),
                  )
                : ValueDelegate.color(
                    const ['**'],
                    value: Colors.blueAccent,
                  ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeStream = ref.watch(noticeStudentGetProvider);

    return noticeStream.when(data: (snapshot) {
      final notices = snapshot.docs;
      final unreadNotices = notices.where((notice) => !notice.data().read);
      if (unreadNotices.isEmpty) {
        return lottieIcon();
      } else {
        return Badge.count(
          count: unreadNotices.length,
          child: lottieIcon(),
        );
      }
    }, error: (_, __) {
      return lottieIcon();
    }, loading: () {
      return lottieIcon();
    });
  }
}
