import 'package:flutter/material.dart';

import '../../../../../../../../components/widgets/card_widget/card_widget.dart';

class DefectImage extends StatelessWidget {
  final List<Widget> children;
  const DefectImage({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      boxPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      crossAxisAlignment: CrossAxisAlignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: children,
      ),
    );
  }
}
