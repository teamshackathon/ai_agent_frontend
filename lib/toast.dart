import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

/// 警告トースト（およびログ）を出力
/// Object?にはnullを含めてあらゆる型のデータが入れられる
void warningToast({String? toast, Object? log}) {
  if (toast != null) Fluttertoast.showToast(msg: toast);
  if (log != null) Logger().w(log);
}

/// 情報トースト（およびログ）を出力
/// Object?にはnullを含めてあらゆる型のデータが入れられる
void infoToast({String? toast, Object? log}) {
  if (toast != null) Fluttertoast.showToast(msg: toast);
  if (log != null) Logger().i(log);
}
