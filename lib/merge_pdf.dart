import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class MergePDF extends StatefulWidget {
  const MergePDF({super.key});

  @override
  State<MergePDF> createState() => _MergePDFState();
}

class _MergePDFState extends State<MergePDF> {

  Future<void> mergePDFs() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result == null) return;

    PdfDocument mergedDocument = PdfDocument();

    for (var file in result.files) {

      final bytes = File(file.path!).readAsBytesSync();

      PdfDocument document = PdfDocument(inputBytes: bytes);

      for (int i = 0; i < document.pages.count; i++) {
        mergedDocument.pages.add().graphics.drawPdfTemplate(
          document.pages[i].createTemplate(),
          const Offset(0, 0),
        );
      }

      document.dispose();
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/merged_pdf.pdf");

    await file.writeAsBytes(await mergedDocument.save());

    mergedDocument.dispose();

    OpenFilex.open(file.path);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Merge PDFs"),
      ),

      body: Center(
        child: ElevatedButton(
          onPressed: mergePDFs,
          child: const Text("Select PDFs to Merge"),
        ),
      ),
    );

  }
}