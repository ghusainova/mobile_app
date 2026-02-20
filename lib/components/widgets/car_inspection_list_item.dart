import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/app_colors.dart';

class CarInspectionItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final Color subtitleColor;
  final String? icon;
  final void Function() onPressed;

  const CarInspectionItem({
    required this.title,
    required this.onPressed,
    super.key,
    this.icon,
    this.subtitle,
    this.subtitleWidget,
    this.subtitleColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon != null ? SvgPicture.asset(icon!) : null,
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(color: subtitleColor),
            )
          : subtitleWidget,
      trailing: const Icon(Icons.chevron_right, color: AppColors.borderDark),
      onTap: onPressed,
    );
  }
}
