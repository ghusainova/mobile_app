import 'package:flutter/material.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/text_field_widget.dart';

class DataForDocPrintingPage extends StatelessWidget {
  const DataForDocPrintingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Данные для печати акта',
      pageTitle:
          'Заполните данные для авто и распечатайте акт', //TODO: add brand model year
      children: [
        const TextFieldWidget(
          labelText: 'Компания',
          readOnly: true,
          margin: EdgeInsets.only(top: 16, bottom: 8),
          suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
        ),
        const TextFieldWidget(
          labelText: 'ФИО водителя эвакуатора',
          margin: EdgeInsets.only(top: 16, bottom: 8),
        ),
        const TextFieldWidget(
          labelText: 'Номер пломбы на ключах',
          margin: EdgeInsets.only(top: 16, bottom: 8),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              onPressed: () => _onSubmit(context),
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit(BuildContext context) {
    SalesContractRoute(
      SalesContractRouteArgs(
        title: 'Акт приема передачи',
        subtitle:
            'Подпишите акт приема передачи с водителем эвакуатора и отсканируйте подписанный акт',
        onSubmit: () => const BuyerQueueRoute().go(context),
      ),
    ).push(context);
  }
}
