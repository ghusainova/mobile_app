import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';

// ignore: must_be_immutable
class HideShowButton extends StatefulWidget {
  final void Function(bool isShown) toggleIsShown;
  const HideShowButton({required this.toggleIsShown, super.key});

  @override
  State<HideShowButton> createState() => _HideShowButtonState();
}

class _HideShowButtonState extends State<HideShowButton> {
  bool isShown = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onToggle,
      child: Text(
        isShown ? 'Скрыть' : 'Показать полностью',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.buttonBlue),
      ),
    );
  }

  void onToggle() {
    setState(() => isShown = !isShown);
    widget.toggleIsShown(isShown);
  }
}
