import 'package:sakura/widget/utils/sakura_progress_indicator.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  /// インジケータを中央に表示できるボタン
  /// isLoadingにtrueを入れるとインジケータを表示し、操作を無効化
  /// enabledにfalseを入れると操作を無効化
  const LoadingButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.width = 120,
    this.height = 40, // 少し高さを変更
  });

  final bool isLoading, enabled;
  final double width, height;
  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  enabled ? Colors.pinkAccent.shade100 : Colors.grey.shade300,
              // 無効化時の色
              foregroundColor: enabled ? Colors.white : Colors.grey.shade600,
              // 無効化時のテキスト色
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25), // 丸みを強調
              ),
              elevation: 3,
              // 影を追加
              shadowColor: Colors.pinkAccent.shade100.withOpacity(0.4),
            ),
            onPressed: (isLoading || !enabled) ? null : onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: height * 0.4, // サイズを高さに基づいて調整
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (isLoading)
          Center(
            child: SizedBox(
              width: height,
              height: height,
              child: const SakuraProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
