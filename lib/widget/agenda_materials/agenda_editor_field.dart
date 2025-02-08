import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AgendaEditorField extends HookWidget {
  const AgendaEditorField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onComplete,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    required this.editable,
  });

  final String? initialValue;
  final ValueChanged<String>? onChanged, onComplete;
  final int? maxLines;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    final text = useState<String>(initialValue ?? "");
    return TextFormField(
      inputFormatters: inputFormatters,
      enabled: editable,
      maxLines: maxLines,
      textAlign: textAlign,
      initialValue: text.value,
      onChanged: (str) {
        text.value = str;
        if (onChanged != null) {
          onChanged!(str);
        }
      },
      onEditingComplete: () {
        if (onComplete != null) {
          onComplete!(text.value);
        }
      },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
        if (onComplete != null) {
          onComplete!(text.value);
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.lightBlue.shade200,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.lightBlue.shade200,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Colors.lightBlue.shade400,
          ),
        ),
        filled: true,
        fillColor: Colors.lightBlue.shade50,
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black87,
      ),
    );
  }
}
