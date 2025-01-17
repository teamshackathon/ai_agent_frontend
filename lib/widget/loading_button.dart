import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  /// インジケータを中央に表示できるボタン
  ///
  /// isLoadingにtrueを入れるとインジケータを表示し、操作を無効化
  ///
  /// enabledにfalseを入れると操作を無効化
  const LoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width = 120,
    this.height = 30,
  });

  final bool isLoading, enabled;
  final double width, height;
  final String text;

  // callbackを書くことで、実際の処理をWidget外で記述することができる
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // childrenのWidget達を重ねて表示することができるWidget
    // 上に書かれたものほど、下のレイヤーに表示される
    return Stack(
      // 特に位置を指定しなかったWidget達が
      // デフォルトでStack上の中央に配置される
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            // onPressedにnullの時、ボタンが無効化される仕様
            onPressed: (isLoading || !enabled) ? null : onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: height * 0.5,
              ),
            ),
          ),
        ),
        // childrenの中でif文を書くことで表示非表示を変えられる
        if (isLoading)
          // 親Widget上でどの位置に子Widgetを配置するか指定できるWidget
          Positioned(
            width: height * 0.8,
            height: height * 0.8,
            child: CircularProgressIndicator(
              strokeWidth: height * 0.1,
            ),
          ),
      ],
    );
  }
}
