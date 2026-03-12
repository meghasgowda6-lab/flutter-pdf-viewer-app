import 'package:flutter/material.dart';

import 'open_pdf.dart';
import 'scan_pdf.dart';
import 'text_to_pdf.dart';
import 'merge_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Tools"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            buildButton(context, "Open PDF", const OpenPDF()),

            buildButton(context, "Scan Document", const ScanPDF()),

            buildButton(context, "Create PDF from Text", const TextToPDF()),

            buildButton(context, "Merge PDFs", const MergePDF()),

          ],
        ),
      ),
    );

  }
}