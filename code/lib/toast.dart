import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

/// 警告トースト（およびログ）を出力
/// Object?にはnullを含めてあらゆる型のデータが入れられる
void warningToast({required String toast, Object? log}){
  Fluttertoast.showToast(msg: toast);
  if(log != null)Logger().w(log);
}

/// 情報トースト（およびログ）を出力
/// Object?にはnullを含めてあらゆる型のデータが入れられる
void infoToast({required String toast, Object? log}){
  Fluttertoast.showToast(msg: toast);
  if(log != null)Logger().i(log);
}