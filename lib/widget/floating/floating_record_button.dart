import 'dart:async';
import 'dart:typed_data';

import 'package:code/data/record/record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:record/record.dart';

class AudioRecorderTest extends HookConsumerWidget {
  const AudioRecorderTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recorder = ref.watch(recordProvider);
    final recorderNot = ref.read(recordProvider.notifier);
    final popState = useState<bool>(false);

    void lessonStart() async {
      await recorderNot.startRecording();
    }

    void lessonFinish() async {
      await recorderNot.stopRecording();
    }

    useEffect(() {
      lessonStart();
      return () {
        lessonFinish();
      };
    }, []);

    return Column(
      verticalDirection: VerticalDirection.up,
      children: [
        FloatingActionButton(
          onPressed: () => popState.value = true,
        ),
        if(popState.value)
          SizedBox(
          width: 50,
          height: 30,
          child: InkWell(
            onTap: (){
              lessonFinish();
            },
            child: Card(child: Text("授業終了")),
          ),
        )
      ],
    );
  }
}
