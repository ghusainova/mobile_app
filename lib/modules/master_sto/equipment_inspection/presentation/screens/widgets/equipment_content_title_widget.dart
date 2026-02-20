import 'package:flutter/material.dart';

import '../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';

class EquipmentContentTitleWidget extends StatelessWidget {
  final String text;

  const EquipmentContentTitleWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyBottom,
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
