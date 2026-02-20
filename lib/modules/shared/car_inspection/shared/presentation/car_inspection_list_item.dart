import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/styles/app_colors.dart';

class CarInspectionItem extends StatelessWidget {
  final String title;
  final String icon;
  final void Function() onPressed;

  const CarInspectionItem({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      trailing: const Icon(Icons.chevron_right, color: AppColors.borderDark),
      onTap: onPressed,
    );
  }
}
