import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ActivitySelectableFilterButton extends HookWidget {
  const ActivitySelectableFilterButton({
    super.key,
    required this.selected,
    required this.onPressed,
    required this.child,
  });

  final bool selected;
  final VoidCallback? onPressed;
  final Widget child;

  static const ButtonStyle style = ButtonStyle(
    foregroundColor: WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{
      WidgetState.selected: Colors.white,
    }),
    backgroundColor: WidgetStateProperty<Color?>.fromMap(<WidgetState, Color>{
      WidgetState.selected: Colors.indigo,
    }),
  );

  @override
  Widget build(BuildContext context) {
    final statesController = useMemoized(
      () => WidgetStatesController(
        <WidgetState>{if (selected) WidgetState.selected},
      ),
      [selected],
    );

    useEffect(() {
      statesController.update(WidgetState.selected, selected);
      return null;
    }, [selected]);

    return TextButton(
      statesController: statesController,
      style: style,
      onPressed: onPressed,
      child: child,
    );
  }
}
