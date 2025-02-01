import 'package:flutter/material.dart';

import '../../data/quiz/quiz.dart';

class SelectListEditable extends StatelessWidget {
  const SelectListEditable({
    super.key,
    required this.options,
    required this.onChanged,
    required this.editable,
    required this.correctAnswer,
  });

  final List<Option> options;
  final bool editable;
  final String correctAnswer;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
//  final ValueChanged<List<Option>> onChanged;
  final void Function(List<Option>, String) onChanged;

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
            child: Row(
              children: [
                Radio(
                  value: options[index].word,
                  groupValue: correctAnswer,
                  onChanged: (value) => onChanged(options, value ?? ""),
                ),
                TextFormField(
                  initialValue: options[index].word,
                  onChanged: (str) {
                    var list = [
                      for (var i = 0; i < options.length; i++)
                        i == index ? options[i].copyWith(word: str) : options[i]
                    ];
                    if(list[index].word == options[index].word){
                      onChanged(list, correctAnswer);
                    }else{
                      onChanged(list, str);
                    }
                    
                  },
                  enabled: editable,
                ),
              ],
            ),
          ),
        ));
  }
}
