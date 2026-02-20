import 'package:flutter/material.dart';

import '../buttons/icon_button_widget.dart';

class AppBarCloseActionWidget extends StatelessWidget {
  final Function()? onPressed;
  const AppBarCloseActionWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      icon: const Icon(Icons.close),
      onTap: () {
        if (onPressed != null) onPressed!();
      },
    );
  }
}
