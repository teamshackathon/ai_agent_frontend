import 'package:flutter/material.dart';

class SelectListEditable extends StatelessWidget {
  const SelectListEditable({
    super.key,
    required this.texts,
    required this.onChanged,
    required this.editable,
  });

  final List<Map<String, String>> texts;
  final bool editable;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final ValueChanged<List<Map<String, String>>> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 250,
      child: ListView.builder(
        itemCount: texts.length,
        itemBuilder: (context, index) => SizedBox(
          height: 50,
          width: 120,
          child: TextFormField(
            initialValue: texts[index]["item_word"],
            onChanged: (value) {
              texts[index]["item_word"] = value;
              onChanged(texts);
            },
            enabled: editable,
          ),
        ),
      ),
    );
  }
}
