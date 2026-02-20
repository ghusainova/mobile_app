import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';

class DocsPrintBtnWidget extends StatelessWidget {
  final String base64String;
  const DocsPrintBtnWidget({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    return BlueButton(
      text: 'Распечатать',
      onPressed: () => PdfPreviewRoute(base64String).push(context),
    );
  }
}
