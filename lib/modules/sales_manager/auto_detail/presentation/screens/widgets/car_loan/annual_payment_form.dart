import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../../catalog/data/models/credit.dart';
import 'credit_term_options.dart';

class AnnualPaymentForm extends StatelessWidget {
  final Credit creditInfo;

  const AnnualPaymentForm({required this.creditInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      shadow: true,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Ежемесячный платеж',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            AnnualPaymentAmount(creditInfo: creditInfo),
            CreditTermOptions(creditInfo: creditInfo),
          ],
        ),
      ),
    );
  }
}

class AnnualPaymentAmount extends StatelessWidget {
  final Credit creditInfo;

  const AnnualPaymentAmount({required this.creditInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        formatNum(
          creditInfo.annualPaymentAmount.toString(),
          addCurrencySign: true,
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
