import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';
import '../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../../../components/widgets/yellow_price.dart';
import '../../../../../shared/_data/models/auto_info.dart';

class ItemCardPriceWidget extends StatelessWidget {
  final AutoInfo? autoInfo;

  const ItemCardPriceWidget(this.autoInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text(
            formatNum(autoInfo?.priceSelling, addCurrencySign: true),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          if ((autoInfo?.credit?.annualPaymentAmount ?? 0) > 0)
            YellowPriceTagWidget(
              price: autoInfo!.credit!.annualPaymentAmount.toString(),
              margin: const EdgeInsets.only(left: 12, right: 4),
            ),
          if ((autoInfo?.credit?.creditTerm ?? 0) > 0)
            Text(
              'x${autoInfo!.credit!.creditTerm}',
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
