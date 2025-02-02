import 'package:code/test/record_and_play.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/dummy_base_page.dart';

class DummyProfilePage extends ConsumerWidget {
  const DummyProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(audioRecordServiceProvider);
    final recordNot = ref.read(audioRecordServiceProvider.notifier);
    final player = ref.watch(audioPlayServiceProvider);
    final playerNot = ref.read(audioPlayServiceProvider.notifier);

    return DummyBasePage(
      pageTitle: "ダミーマイページ",
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              if(record.isRecording){
                recordNot.stopRecording();
              }else{
                recordNot.startRecording();
              }
            },
            child: record.isRecording ? Text("録音停止") : Text("録音開始"),
          ),
          ElevatedButton(
            onPressed: () {
              if(player.isPlaying){
                playerNot.pausePlaying();
              }else{
                playerNot.startPlaying();
              }
            },
            child: player.isPlaying ? Text("再生停止") : Text("再生開始"),
          ),
        ],
      ),
    );
  }
}
