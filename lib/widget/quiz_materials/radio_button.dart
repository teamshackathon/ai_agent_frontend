import 'package:flutter/material.dart';

import '../../data/quiz/quiz.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.options,
    required this.onChanged,
    required this.stateText,
  });

  final List<Option> options;
  final String stateText;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: options.length,
      itemBuilder: (context, index) {
        return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RadioListTile(
              title: Text(options[index].word),
              value: options[index].word,
              groupValue: stateText,
              onChanged: onChanged,
              
            ));
      },
    );
  }
}
