import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.texts,
    required this.onChanged,
    required this.stateText,
  });

  final List<String> texts;
  final String stateText;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    // childrenのWidget達を重ねて表示することができるWidget
    // 上に書かれたものほど、下のレイヤーに表示される
    return ListView.builder(
      shrinkWrap: true,
      itemCount: texts.length,
      itemBuilder: (context, index) {
        return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RadioListTile(
              title: Text(texts[index]),
              value: texts[index],
              groupValue: stateText,
              onChanged: onChanged,
            ));
      },
    );
  }
}
