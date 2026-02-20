import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';
import '../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../../shared/_data/models/auto_info.dart';

class ItemCardDescriptionWidget extends StatelessWidget {
  final AutoInfo? autoInfo;

  const ItemCardDescriptionWidget(this.autoInfo, {super.key});

  String get mileage => autoInfo?.auto?.mileage != null
      ? '${formatNum(autoInfo!.auto?.mileage.toString())} км / '
      : '';

  String get engineVolume =>
      autoInfo?.auto?.engine != null ? '${autoInfo!.auto!.engine} л / ' : '';

  String get engineType => autoInfo?.auto?.engineType != null
      ? '${autoInfo!.auto!.engineType.toLowerCase()} / '
      : '';

  String get transmissionType => autoInfo?.auto?.transmission != null
      ? '${autoInfo!.auto!.transmission.toLowerCase()} / '
      : '';

  String get vin => autoInfo?.auto?.vin != null ? autoInfo!.auto!.vin : '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$mileage$engineVolume$engineType$transmissionType$vin',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.inactiveText),
          ),
        ],
      ),
    );
  }
}
