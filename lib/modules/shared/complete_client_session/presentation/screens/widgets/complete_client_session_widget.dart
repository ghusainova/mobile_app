import 'package:flutter/material.dart';

import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';

class CompleteClientSessionWidget extends StatelessWidget {
  final VoidCallback onTap;

  const CompleteClientSessionWidget({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyTop,
      shadow: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: OutlinedBlueButton(text: 'Завершить работу', onPressed: onTap),
      ),
    );
  }
}
