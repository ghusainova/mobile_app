import 'package:flutter/material.dart';

import '../../../modules/shared/_data/models/auto_info.dart';
import 'car_item_card_widget.dart';

class HorizontalCardListWidget extends StatelessWidget {
  final List<AutoInfo> orders;
  final bool pushReplace;

  const HorizontalCardListWidget({
    super.key,
    required this.orders,
    this.pushReplace = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: orders.length,
        itemBuilder: (context, index) =>
            CarItemCardWidget(order: orders[index], pushReplace: pushReplace),
        separatorBuilder: (context, index) =>
            SizedBox(width: index + 1 != orders.length ? 12 : 0),
      ),
    );
  }
}
