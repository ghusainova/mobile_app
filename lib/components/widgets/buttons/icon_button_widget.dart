import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const IconButtonWidget({
    required this.icon, required this.onTap, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon,
      splashRadius: 20,
      onPressed: onTap,
    );
  }
}
