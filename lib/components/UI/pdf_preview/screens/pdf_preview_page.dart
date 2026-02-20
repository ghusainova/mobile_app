import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import '../../../widgets/appbar/appbar_widget.dart';
import '../../../widgets/no_content_widget.dart';

class PdfPreviewPage extends StatefulWidget {
  final String base64String;

  const PdfPreviewPage(this.base64String, {super.key});

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  final bgColor = Colors.black.withOpacity(0.8);
  File? pdfFile;

  @override
  void initState() {
    decodeString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        'Документы',
        foregroundColor: Colors.white,
        backgroundColor: bgColor,
        backBtnIcon: const Icon(Icons.close, color: Colors.white),
      ),
      body: pdfFile != null
          ? PdfPreview(
              maxPageWidth: 700,
              canDebug: kDebugMode,
              canChangeOrientation: false,
              canChangePageFormat: false,
              actionBarTheme: PdfActionBarTheme(backgroundColor: bgColor),
              build: (format) => pdfFile!.readAsBytesSync(),
            )
          : NoContentWidget(
              onRefresh: decodeString,
              errorMessage: 'Ошибка чтения файла',
            ),
    );
  }

  void decodeString() async {
    if (widget.base64String.isEmpty) {
      pdfFile = null;
      return;
    }

    try {
      final bytes = base64Decode(widget.base64String);

      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/decoded.pdf';

      final file = await File(tempFilePath).writeAsBytes(bytes);

      setState(() {
        pdfFile = file;
      });
    } catch (e) {
      setState(() {
        pdfFile = null;
      });
    }
  }
}
