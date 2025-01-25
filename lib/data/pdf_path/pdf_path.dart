import 'dart:typed_data';

import 'package:code/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_path.g.dart';

@Riverpod(keepAlive: true)
class PdfPath extends _$PdfPath {
  @override
  String build() => "";

  void init() => state = "";

  void add(String path) => state = path;

  Uri getUri(){
    infoToast(log: state);
    return Uri.parse(state);
  }
}
