import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  /// インジケータを中央に表示できるボタン
  ///
  /// isLoadingにtrueを入れるとインジケータを表示し、操作を無効化
  ///
  /// enabledにfalseを入れると操作を無効化
  const RadioButton({
    super.key,
    required this.text,
    required this.onChanged,
    required this.stateText,
  });

  final List<String> text;
  final String stateText;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    // childrenのWidget達を重ねて表示することができるWidget
    // 上に書かれたものほど、下のレイヤーに表示される
    return ListView.builder(
      shrinkWrap: true,
      itemCount: text.length,
      itemBuilder: (context, index) {
        return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RadioListTile(
              title: Text(text[index]),
              value: text[index],
              groupValue: stateText,
              onChanged: onChanged,
            ));
      },
    );
  }
}
