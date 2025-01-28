import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/dummy_base_page.dart';

class DummyMain extends ConsumerWidget {
  const DummyMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySize = MediaQuery.sizeOf(context);
    final List<String> list = ["チョコ", "バナナ"];

    return DummyBasePage(
      backgroundColor: Colors.blue,
      pageTitle: "ダミーメイン",
      body: SizedBox.expand(
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.5,
          heightFactor: 0.9,
          child: PageView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Flexible(
                child: Column(children: [
                    Text(list[index]),
                  ElevatedButton(onPressed: (){}, child: Text("ダミー")),
                ],),
              );
            },
          ),
        ),
      ),
    );
  }
}
