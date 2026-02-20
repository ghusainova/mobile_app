import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'widgets/docs_buttons_bar_widget.dart';
import 'widgets/docs_carousel_widget.dart';
import 'widgets/docs_preview_bar_widget.dart';

class DocsScanResultViewPage extends StatefulWidget {
  final List<String> docs;

  const DocsScanResultViewPage(this.docs, {super.key});

  @override
  State<DocsScanResultViewPage> createState() => _DocsScanResultViewPageState();
}

class _DocsScanResultViewPageState extends State<DocsScanResultViewPage> {
  final carouselController = CarouselController();
  late List<File> docFiles;

  @override
  void initState() {
    super.initState();
    docFiles = widget.docs.map((e) => File(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          DocsCarouselWidget(
            docFiles: docFiles,
            carouselController: carouselController,
          ),
          DocsPreviewBarWidget(
            docFiles: docFiles,
            onDelete: onDeleteDocs,
          ),
          const DocsBtnsBarWidget(),
        ],
      ),
    );
  }

  void onDeleteDocs(int index) {
    setState(() => docFiles = docFiles..removeAt(index));
  }
}
