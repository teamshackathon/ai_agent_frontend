import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// カスタムスタイルのトーストを表示
void showCustomToast({
  required String message,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Color backgroundColor = const Color(0xFFFFF0F5), // 淡いピンク
  Color textColor = const Color(0xFF6A1B9A), // 濃いめのピンクパープル
  double fontSize = 18.0,
}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: gravity,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}

/// 警告トースト
void warningToast({String? toast, Object? log}) {
  if (toast != null) {
    showCustomToast(
      message: toast,
      backgroundColor: const Color(0xFFFFCDD2), // 明るいサクラ色
      textColor: Colors.redAccent,
    );
  }
  if (log != null) Logger().w(log);
}

/// 情報トースト
void infoToast({String? toast, Object? log}) {
  if (toast != null) {
    showCustomToast(
      message: toast,
      backgroundColor: const Color(0xFFFFF0F5), // 優しいピンク
      textColor: const Color(0xFF4CAF50), // 穏やかなグリーン
    );
  }
  if (log != null) Logger().i(log);
}
