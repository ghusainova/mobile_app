import 'package:flutter/material.dart';

import 'blue_button.dart';
import 'outlined_blue_button.dart';

class ButtonsBar extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final String cancelBtnLabel;
  final String submitBtnLabel;
  final void Function() onClear;
  final void Function() onConfirm;

  const ButtonsBar({
    required this.onClear, required this.onConfirm, super.key,
    this.padding = EdgeInsets.zero,
    this.cancelBtnLabel = 'Сбросить',
    this.submitBtnLabel = 'Применить',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(
            child: OutlinedBlueButton(
              onPressed: onClear,
              text: cancelBtnLabel,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: BlueButton(
              text: submitBtnLabel,
              margin: EdgeInsets.zero,
              onPressed: onConfirm,
            ),
          ),
        ],
      ),
    );
  }
}
