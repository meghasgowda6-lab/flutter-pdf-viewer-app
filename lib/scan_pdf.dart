import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class ScanPDF extends StatefulWidget {
  const ScanPDF({super.key});

  @override
  State<ScanPDF> createState() => _ScanPDFState();
}

class _ScanPDFState extends State<ScanPDF> {

  Future<void> scanDocument() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final pdf = pw.Document();
    final imageFile = File(image.path);
    final imageBytes = await imageFile.readAsBytes();
    final imageProvider = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(imageProvider),
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/scanned_document.pdf');

    await file.writeAsBytes(await pdf.save());

    await OpenFilex.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Document"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: scanDocument,
          child: const Text("Scan Document"),
        ),
      ),
    );
  }
}