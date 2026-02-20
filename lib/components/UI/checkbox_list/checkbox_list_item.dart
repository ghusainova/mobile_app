import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class CheckboxItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function(bool? status) onSelect;

  const CheckboxItem({
    required this.title, required this.onSelect, super.key,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.red,
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: isSelected,
      onChanged: (status) => onSelect(status),
    );
  }
}
