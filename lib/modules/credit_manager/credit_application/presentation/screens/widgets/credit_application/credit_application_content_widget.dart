import 'package:flutter/material.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../../components/widgets/cached_image_widget.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../data/models/credit_application_auto.dart';
import '../../../../data/models/credit_application_conditions.dart';
import '../../../../data/models/credit_application.dart';
import '../more_about_modal.dart';
import 'rejection_status_widget.dart';

class CreditApplicationContentWidget extends StatelessWidget {
  final CreditApplication creditApplication;

  const CreditApplicationContentWidget(this.creditApplication, {super.key});

  CreditApplicationAuto get _carLoanAuto => creditApplication.auto;

  CreditApplicationConditions get _carLoanConditions =>
      creditApplication.credit;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: 'Заявка на Автокредит',
      margin: const EdgeInsets.only(bottom: 16),
      titleChild: OutlinedBlueButton(
        text: 'Подробнее',
        showBorder: false,
        slim: true,
        onPressed: () => _showMore(context, creditApplication),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImageWidget(
            creditApplication.advert?.urlAdvert,
            width: 104,
            height: 80,
            borderRadius: 16,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //TODO: refactor/beautify
                  '${_carLoanAuto.brand.isEmpty ? _carLoanAuto.brandMVD : _carLoanAuto.brand} ${_carLoanAuto.model.isEmpty ? _carLoanAuto.modelMVD : _carLoanAuto.model}, ${_carLoanAuto.year}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (_carLoanConditions.summaCred > 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 4),
                    child: Text(
                      'Стоимость авто: ${_formatPrice(_carLoanConditions.summaCred.toInt())}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.inactiveText),
                    ),
                  ),
                if (creditApplication.credit.initialFee > 0)
                  Text(
                    'Первоначальный взнос: ${_formatPrice(creditApplication.credit.initialFee.toInt())}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.inactiveText),
                  ),
                const RejectionStatusWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(int? price) {
    return formatNum(price.toString(), addCurrencySign: true);
  }

  void _showMore(BuildContext context, CreditApplication carLoanOrder) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) => MoreAboutModal(carLoanOrder),
    );
  }
}
