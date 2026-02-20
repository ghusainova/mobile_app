import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class CheckBoxTileVariantWidget extends StatelessWidget {
  final String title;
  final bool enabled;
  final EdgeInsets checkBoxPadding;
  final VoidCallback onTap;

  const CheckBoxTileVariantWidget({
    required this.title, required this.enabled, required this.checkBoxPadding, required this.onTap, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: CheckboxListTile(
        activeColor: AppColors.red,
        contentPadding: checkBoxPadding,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        value: enabled,
        onChanged: (status) => onTap(),
      ),
    );
  }
}
