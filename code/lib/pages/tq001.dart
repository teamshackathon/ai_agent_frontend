import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TakeQuizzes extends ConsumerWidget {
  const TakeQuizzes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('tq001'),
          ],
        ),
      ),
    );
  }
}
