import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../route/route.dart';
import '../../../widget/base_page/base_page.dart';

/// hotreloadの際は一度mainに帰って
class StudentTools extends ConsumerWidget {
  const StudentTools({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    const widthFactor = 0.95;
    const heightFactor = 0.95;

    return BasePage(
      pageTitle: "生徒機能選択",
      body: Center(
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: StudentToolsDisplay(
            displayWidth: size.width * widthFactor,
            displayHeight: size.height * widthFactor,
          ),
        ),
      ),
    );
  }
}

class StudentToolsDisplay extends ConsumerWidget {
  const StudentToolsDisplay({
    super.key,
    required this.displayWidth,
    required this.displayHeight,
  });

  final double displayWidth, displayHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        InkWell(
          // onTap: () async {
          //   await getText(ref: ref);
          //   if (context.mounted) {
          //     GoRouter.of(context).push(Routes.studentReading);
          //   }
          // },
          onTap: (){
            GoRouter.of(context).push(Routes.studentAgenda);
          },
          child: Card(
            child: Column(
              children: [
                Text(""),
                Text("授業内容"),
                Text(""),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            GoRouter.of(context).push(Routes.studentQuiz);
          },
          child: Card(
            child: Column(
              children: [
                Text(""),
                Text("小テストの確認"),
                Text(""),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            child: Column(
              children: [
                Text(""),
                Text("宿題"),
                Text(""),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
