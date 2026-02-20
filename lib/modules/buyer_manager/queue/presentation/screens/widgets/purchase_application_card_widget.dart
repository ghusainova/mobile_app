import 'package:flutter/material.dart';

import '../../../../../shared/_data/models/auto_info.dart';
import 'application_card/applicaiton_card_widget.dart';
import 'work_with_client_btns_widget.dart';

class PurchaseApplicationCardWidget extends StatelessWidget {
  final AutoInfo order;

  const PurchaseApplicationCardWidget(
    this.order, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
          child: Text(
            'Заявка на выкуп',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        ApplicationCardWidget(order),
        WorkWithClientBtnsWidget(),
      ],
    );
  }
}
