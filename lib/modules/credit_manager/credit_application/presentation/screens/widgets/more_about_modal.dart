import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/UI/modal_appbar.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/table_content_item.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../shared/_domain/utility/formatters/date_formatter.dart';
import '../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../application_status/domain/bloc/credit_application_status_bloc.dart';
import '../../../../shared/_data/constants/credit_status.dart';
import '../../../data/models/credit_application.dart';

class MoreAboutModal extends StatelessWidget {
  final CreditApplication creditApplication;

  const MoreAboutModal(this.creditApplication, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: ModalAppBar(text: 'Заявка на Автокредит'),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.7,
          child: RawScrollbar(
            thumbVisibility: true,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: infoList(),
            ),
          ),
        ),
        if (_isSellerCarDataReceived)
          OutlinedBlueButton(
            text: 'Клиент хочет оформить другое авто',
            margin: const EdgeInsets.all(16),
            onPressed: () => _registerAnotherCar(context),
          ),
      ],
    );
  }

  bool get _isSellerCarDataReceived =>
      getIt
          .get<CreditApplicationStatusBloc>()
          .statusList
          .firstWhereOrNull(
            (e) => e.statusCode == CreditStatus.getSellerCheck,
          )
          ?.isDone ==
      true;

  void _registerAnotherCar(BuildContext context) {
    context.pop();
    const GetSellerDataRoute().push(context);
  }

  List<Widget> infoList() {
    return [
      TableContentItem(
        title: Constants.brand,
        value: creditApplication.auto.brand,
      ),
      TableContentItem(
        title: Constants.model,
        value: creditApplication.auto.model,
      ),
      TableContentItem(
        title: Constants.year,
        value: creditApplication.auto.year,
      ),
      TableContentItem(
        title: 'Стоимость авто',
        value: formatNum(
          creditApplication.auto.price.toInt().toString(),
          addCurrencySign: true,
        ),
      ),
      TableContentItem(
        title: 'Первоначальный \nвзнос',
        value: formatNum(
          creditApplication.credit.initialFee.toInt().toString(),
          addCurrencySign: true,
        ),
      ),
      TableContentItem(
        title: 'Сумма кредита',
        value: formatNum(
          creditApplication.credit.summaCred.toInt().toString(),
          addCurrencySign: true,
        ),
      ),
      TableContentItem(
        title: 'Срок кредита',
        value: '${creditApplication.credit.termCred} месяцев',
      ),
      TableContentItem(
        title: 'Дата первого \nплатежа',
        value: formatDate(creditApplication.credit.dayPay),
      ),
      TableContentItem(
        title: 'Переплата по \nкредиту',
        value: formatNum(
          creditApplication.credit.overPaid.toString(),
          addCurrencySign: true,
        ),
      ),
    ];
  }
}
