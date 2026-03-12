import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TextToPDF extends StatefulWidget {
  const TextToPDF({super.key});

  @override
  State<TextToPDF> createState() => _TextToPDFState();
}

class _TextToPDFState extends State<TextToPDF> {

  final TextEditingController controller = TextEditingController();

  Future<void> createPDF() async {

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Text(controller.text);
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create PDF from Text"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: controller,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter text here",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: createPDF,
              child: const Text("Create PDF"),
            ),

          ],
        ),
      ),
    );
  }
}