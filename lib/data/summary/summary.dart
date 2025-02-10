import 'package:freezed_annotation/freezed_annotation.dart';

part "summary.freezed.dart";

@freezed
class Summary with _$Summary {
  const Summary._();

  const factory Summary({
    required String markdown,
    required List<String> imgPaths,
  }) = _Summary;

  factory Summary.fromMap(Map<String, dynamic> map) {
    final List<String> list = [];
    for (var d in map["images"] ?? []) {
      list.add(d);
    }
    return Summary(
      markdown: map["markdown"] ?? "",
      imgPaths: list,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "markdown": markdown,
      "images": imgPaths,
    };
  }

  factory Summary.isBlank() {
    return Summary(markdown: "", imgPaths: []);
  }
}
