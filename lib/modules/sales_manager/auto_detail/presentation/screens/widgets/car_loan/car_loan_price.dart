import 'package:flutter/material.dart';

import '../../../../../../shared/_domain/utility/formatters/num_formatter.dart';
import '../../../../../../../components/widgets/text_field_widget.dart';
import '../../../../../catalog/data/models/credit.dart';

class CarLoanPrice extends StatelessWidget {
  final Credit creditInfo;
  const CarLoanPrice({required this.creditInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      readOnly: true,
      textController: TextEditingController.fromValue(
        TextEditingValue(
          text: formatNum(creditInfo.price.toString(), addCurrencySign: true),
        ),
      ),
      labelText: 'Стоимость авто',
      margin: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
