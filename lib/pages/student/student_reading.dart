import 'package:code/data/pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';


/// hotreloadの際は一度mainに帰って
class StudentReading extends ConsumerWidget {
  const StudentReading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = ref.watch(pdfProvider);

    return Scaffold(
      body: PDFView(pdfData: pdf),
    );
  }
}