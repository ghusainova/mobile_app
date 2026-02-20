import 'package:flutter/material.dart';

import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/text_field_widget.dart';

class SellCarSumReasonPage extends StatelessWidget {
  const SellCarSumReasonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Завершение работы',
      pageTitle: 'За какую сумму владелец готов продать авто',
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: TextFieldWidget(labelText: 'Сумма (опционально)'),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              text: 'Завершить работу',
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}
