import 'package:flutter/material.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/cached_image_widget.dart';
import '../../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../../../shared/_data/models/auto_info.dart';
import 'application_card_title_widget.dart';
import 'application_status.dart';

class ApplicationCardWidget extends StatelessWidget {
  final AutoInfo order;

  const ApplicationCardWidget(this.order, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CachedImageWidget(
              order.auto?.mainPhotoLink,
              width: 104,
              height: 80,
              borderRadius: 8,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ApplicationCardTitleWidget(order),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Цена в объявлении: ${formatPriceText(order.priceSelling)} ₸',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.inactiveText),
                ),
              ),
              if (order.auto?.vin != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'VIN-код: ${order.auto!.vin}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: AppColors.inactiveText),
                  ),
                ),
              const ApplicationStatus(),
            ],
          ),
        ],
      ),
    );
  }
}
