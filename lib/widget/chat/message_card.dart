import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../pages/profile/profile.dart';

class IsMeMessageCard extends HookConsumerWidget {
  const IsMeMessageCard({
    super.key,
    required this.message,
    required this.name,
    required this.iconPath,
  });

  final String message;
  final String name;
  final String iconPath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // 背景色
                  borderRadius: BorderRadius.circular(15), // 角丸
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 影の色
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // 影の位置
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "自分",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            UserIcon(
              iconPath: iconPath,
              name: name,
              radius: 20,
            )
          ],
        ),
      ),
    );
  }
}

class TeacherMessageCard extends StatelessWidget {
  final String message;
  final String name;
  final String iconPath;

  const TeacherMessageCard(
      {super.key,
      required this.message,
      required this.name,
      required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserIcon(
              iconPath: iconPath,
              name: name,
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // 背景色
                  borderRadius: BorderRadius.circular(15), // 角丸
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 影の色
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // 影の位置
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "先生",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class StudentMessageCard extends StatelessWidget {
  final String message;
  final String name;
  final String iconPath;

  const StudentMessageCard(
      {super.key,
      required this.message,
      required this.name,
      required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(left: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserIcon(
              iconPath: iconPath,
              name: name,
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // 背景色
                  borderRadius: BorderRadius.circular(15), // 角丸
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 影の色
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // 影の位置
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
