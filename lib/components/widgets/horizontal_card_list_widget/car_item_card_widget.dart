import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../modules/shared/_data/models/auto_info.dart';
import '../../router/data/routes.dart';
import '../../../modules/shared/_domain/utility/formatters/num_formatter.dart';
import '../../styles/app_colors.dart';
import '../cached_image_widget.dart';
import '../parking_info.dart';

class CarItemCardWidget extends StatelessWidget {
  final AutoInfo order;
  final bool pushReplace;

  const CarItemCardWidget({
    super.key,
    required this.order,
    required this.pushReplace,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToAutoDetails(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.backBase),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(
              order.auto?.mainPhotoLink,
              height: 112,
              width: 160,
              borderRadius: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 8),
              child: Text(
                '${_toUpperCase(order.auto?.brand)} ${_toUpperCase(order.auto?.model)}, ${order.auto?.year ?? ''}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text(
              formatNum(order.priceSelling, addCurrencySign: true),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ParkingInfoWidget(
              order.parking,
              margin: const EdgeInsets.only(top: 8, bottom: 4),
            ),
          ],
        ),
      ),
    );
  }

  String _toUpperCase(String? text) =>
      toBeginningOfSentenceCase((text ?? '').toLowerCase());

  void _navigateToAutoDetails(BuildContext context) {
    final args = AutoDetailRouteArgs(autoInfo: order);

    if (pushReplace) {
      AutoDetailRoute(args).pushReplacement(context);
    } else {
      AutoDetailRoute(args).push(context);
    }
  }
}
