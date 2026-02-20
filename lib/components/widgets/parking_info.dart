import 'package:flutter/material.dart';

import '../../modules/sales_manager/catalog/data/models/parking.dart';
import '../styles/app_colors.dart';

class ParkingInfoWidget extends StatelessWidget {
  final Parking? parking;
  final EdgeInsets margin;
  final double textSize;

  const ParkingInfoWidget(
    this.parking, {
    super.key,
    this.margin = EdgeInsets.zero,
    this.textSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    if (parking?.row == null || parking?.slot == null) {
      return const SizedBox();
    }

    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.neutralBlackAlt,
      ),
      child: Text(
        'Ряд ${parking?.row}, № ${parking?.slot}',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColors.neutralIcon, fontSize: textSize),
      ),
    );
  }
}
