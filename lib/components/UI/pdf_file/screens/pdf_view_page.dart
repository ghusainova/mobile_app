import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

import '../../../widgets/appbar/appbar_widget.dart';

class PdfViewPage extends StatefulWidget {
  final String url;

  const PdfViewPage(this.url, {super.key});

  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  PDFDocument? pdfDoc;

  @override
  void initState() {
    super.initState();
    getPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        'Акт диагностики',
        foregroundColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.8),
        backBtnIcon: const Icon(Icons.close, color: Colors.white),
      ),
      body: pdfDoc != null
          ? PDFViewer(document: pdfDoc!)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> getPdf() async {
    pdfDoc = await PDFDocument.fromURL(widget.url).whenComplete(
      () => setState(() {}),
    );
  }
}
