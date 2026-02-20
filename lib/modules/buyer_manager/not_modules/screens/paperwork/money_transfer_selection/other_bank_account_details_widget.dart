import 'package:flutter/material.dart';

import '../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../components/widgets/text_field_widget.dart';

class OtherBankAccountDetails extends StatelessWidget {
  const OtherBankAccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: 'Укажите реквизиты счета другого банка',
      borderRadius: CardBorderTypeEnum.onlyTop,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            child: TextFieldWidget(labelText: 'Наименование банка'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            child: TextFieldWidget(labelText: 'БИК'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16, bottom: 4),
            child: TextFieldWidget(labelText: 'Номер счета (ИИК)'),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 3.6),
        ],
      ),
    );
  }
}
