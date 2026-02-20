import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/car_inspection_list_item.dart';

class CreditDocumentsContent extends StatelessWidget {
  final List<String> creditDocs;

  const CreditDocumentsContent(this.creditDocs, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: creditDocs.length,
        itemBuilder: (context, index) => CarInspectionItem(
          icon: AppAssets.document,
          title: 'Doc #$index',
          onPressed: () => PdfPreviewRoute(creditDocs[index]).push(context),
        ),
      ),
    );
  }
}
