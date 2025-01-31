import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code/firebase/storage/get_text.dart';
import 'package:code/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../data/firebase/lesson_stream.dart';
import '../../../../widget/base_page/base_page.dart';

class TeacherAgenda extends ConsumerWidget {
  const TeacherAgenda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    // スマホだと戻るボタンに連動して、確認を出すことできるけど
    // Chromeだとできなさそうだから一旦諦め
    // return PopScope(
    //   canPop: false,
    //   onPopInvokedWithResult: (didPop, _) {
    //     if (didPop) return;
    //     if (editing) {
    //     } else {
    //       GoRouter.of(context).pop();
    //     }
    //   },
    //   child: BasePage(
    return BasePage(
      pageTitle: "授業内容確認",

      // childrenを縦に並べるWidget
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: TeacherAgendaDisplay(
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
        ),
      ),
    );
  }
}

class TeacherAgendaDisplay extends HookConsumerWidget {
  const TeacherAgendaDisplay({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
  });

  final double displayWidth, displayHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLessonSnapshot = ref.watch(currentLessonProvider);
    final currentLesson = currentLessonSnapshot?.data();
    final title = useState<String>(currentLesson?.draftAgenda.title ?? "");

    return Stack(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("タイトル"),
              AgendaEditorField(
                initialValue: title.value,
                onComplete: (str) async => await currentLesson?.reference
                    .update({"agenda_draft.title": str}),
              ),
              // Expanded(child: child),
            ],
          ),
        ),
      ],
    );
  }
}

class AgendaEditorField extends HookWidget {
  const AgendaEditorField({
    super.key,
    this.initialValue,
    required this.onComplete,
    this.maxLines = 1,
  });

  final String? initialValue;
  final ValueChanged<String> onComplete;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final text = useState<String>(initialValue ?? "");
    return TextFormField(
      maxLines: maxLines,
      initialValue: text.value,
      onChanged: (str) {
        text.value = str;
      },
      onEditingComplete: () async {
        onComplete(text.value);
      },
      onTapOutside: (_) async {
        FocusScope.of(context).unfocus();
        onComplete(text.value);
      },
    );
  }
}
