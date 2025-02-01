import 'package:code/data/pdf_path/pdf_path.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

/// hotreloadの際は一度mainに帰って
class StudentReading extends ConsumerWidget {
  const StudentReading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfPath = ref.read(pdfPathProvider.notifier);

    return Scaffold(
      body: PdfViewer.uri(pdfPath.getUri()),
    );
  }
}
