import 'package:flutter/material.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';

class BuyoutOfferWidget extends StatelessWidget {
  final bool isWaitingForDecision;

  const BuyoutOfferWidget({super.key, this.isWaitingForDecision = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kolesa.kz готовы купить авто за 4 450 000〒',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Объявление на Kolesa.kz',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: AppColors.primaryBlue),
            ),
          ),
          if (isWaitingForDecision)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '1. Позовите к себе владельца авто\n2. Отправьте решение',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                BlueButton(text: 'Отправить', onPressed: () {}),
              ],
            ),
        ],
      ),
    );
  }
}
