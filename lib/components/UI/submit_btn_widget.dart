import 'package:flutter/material.dart';

import '../widgets/buttons/blue_button.dart';
import '../widgets/card_widget/card_border_type_enum.dart';
import '../widgets/card_widget/card_widget.dart';

class SubmitBtnWidget extends StatelessWidget {
  final String text;
  final bool isEqual;
  final bool isLoading;
  final VoidCallback onPressed;

  const SubmitBtnWidget({
    required this.onPressed, super.key,
    this.text = 'Продолжить',
    this.isLoading = false,
    this.isEqual = false,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyTop,
      margin: const EdgeInsets.only(top: 16),
      boxPadding: const EdgeInsets.only(bottom: 16),
      child: BlueButton(
        text: text,
        isLoading: isLoading,
        onPressed: onPressed,
      ),
    );
  }
}
