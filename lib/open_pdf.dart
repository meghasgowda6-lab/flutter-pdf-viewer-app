import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

class OpenPDF extends StatelessWidget {
  const OpenPDF({super.key});

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      String path = result.files.single.path!;
      await OpenFilex.open(path);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open PDF"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: pickPDF,
          child: const Text("Select PDF"),
        ),
      ),
    );
  }
}