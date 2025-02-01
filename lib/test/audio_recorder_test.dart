import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';

class AudioRecorderTest extends HookConsumerWidget {
  const AudioRecorderTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = AudioRecorder();

    return Placeholder();
  }
}
