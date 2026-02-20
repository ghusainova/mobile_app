import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/card_widget/card_widget.dart';

class CreditApplicationLoadingWidget extends StatelessWidget {
  const CreditApplicationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: MediaQuery.of(context).size.height / 6,
      margin: const EdgeInsets.only(bottom: 16),
      mainAxisAlignment: MainAxisAlignment.center,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
