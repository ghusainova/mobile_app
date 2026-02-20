import 'package:flutter/material.dart';

import '../../../../../../shared/_data/models/auto_info.dart';
import '../../../../../catalog/presentation/widgets/catalog_item_card_widget/catalog_item_card_widget.dart';

class CreditInfoWidget extends StatelessWidget {
  final List<AutoInfo> creditOrders;

  const CreditInfoWidget(this.creditOrders, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: creditOrders.length,
      itemBuilder: (context, index) => CatalogItemCard(
        autoInfo: creditOrders[index],
        showSelectBtn: false,
        fromApprovedCredit: true,
      ),
    );
  }
}
