import 'package:flutter/material.dart';

import '../../modules/shared/_domain/utility/formatters/num_formatter.dart';
import '../styles/app_colors.dart';

class YellowPriceTagWidget extends StatelessWidget {
  final String? price;
  final EdgeInsets? margin;

  const YellowPriceTagWidget({super.key, this.price, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.yellow,
      ),
      child: Text(
        formatNum(price, addCurrencySign: true),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontVariations: [
            const FontVariation('wght', 600),
          ],
        ),
      ),
    );
  }
}
