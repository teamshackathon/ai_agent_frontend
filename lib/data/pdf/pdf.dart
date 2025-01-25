import 'dart:typed_data';

import 'package:code/toast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf.g.dart';

@riverpod
class Pdf extends _$Pdf {
  @override
  Uint8List build() => Uint8List(0);

  void init() => state = Uint8List(0);

  void add(Uint8List pdf) {
    state = pdf;
    infoToast(log: "add pdf");
  }
}
