import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../data/quiz/quiz.dart';

class SelectListEditable extends StatelessWidget {
  const SelectListEditable({
    super.key,
    required this.options,
    required this.onChanged,
    required this.editable,
  });

  final List<Option> options;
  final bool editable;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final ValueChanged<List<Option>> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 250,
      child: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) => SizedBox(
          height: 50,
          width: 120,
          child: TextFormField(
            initialValue: options[index].word,
            onChanged: (str) {
              var list = [
                for (var i = 0; i < options.length; i++)
                  i == index ? options[i].copyWith(word: str) : options[i]
              ];
              onChanged(list);
            },
            enabled: editable,
          ),
        ),
      ),
    );
  }
}
