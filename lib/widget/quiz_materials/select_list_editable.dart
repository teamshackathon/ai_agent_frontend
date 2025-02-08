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
      width: MediaQuery.of(context).size.width * 0.85,
      height: options.length * 55 + 20,
      child: ListView.separated(
        itemCount: options.length,
        itemBuilder: (context, index) => Row(
          children: [
            Radio(
              value: options[index].word,
              groupValue: correctAnswer,
              onChanged: (value) => onChanged(options, value ?? ""),
            ),
            Expanded(
                child: TextFormField(
              maxLines: null,
              initialValue: options[index].word,
              onChanged: (str) {
                var list = [
                  for (var i = 0; i < options.length; i++)
                    i == index ? options[i].copyWith(word: str) : options[i]
                ];

                if (correctAnswer != options[index].word) {
                  onChanged(list, correctAnswer);
                } else {
                  onChanged(list, str);
                }
              },
              enabled: editable,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade400, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            )),
          ],
        ),
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
      ),
    );
  }
}
