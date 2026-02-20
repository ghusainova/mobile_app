import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class CheckKeyWidget extends StatelessWidget {
  final bool enabled;
  final EdgeInsets margin;

  const CheckKeyWidget(
    this.enabled, {
    super.key,
    this.margin = const EdgeInsets.only(right: 12),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: enabled ? AppColors.success : AppColors.backBase,
        shape: BoxShape.circle,
      ),
      margin: margin,
      child: enabled
          ? const Icon(Icons.check, color: Colors.white, size: 16)
          : null,
    );
  }
}
