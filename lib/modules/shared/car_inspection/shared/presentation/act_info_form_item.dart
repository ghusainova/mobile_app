import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../data/models/act_detail.dart';
import '../../../../../components/styles/app_assets.dart';
import '../../../../../components/styles/app_colors.dart';

class ActInfoFormItem extends StatelessWidget {
  final ActDetail item;
  const ActInfoFormItem({required this.item, super.key});

  Widget get _icon => item.isDefect
      ? SvgPicture.asset(AppAssets.failIcon)
      : SvgPicture.asset(AppAssets.successOutlinedIcon);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: _icon,
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        item.equipment,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: item.condition.isNotEmpty
          ? Text(
              _getConditionTitle(item.equipment, item.condition),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.inactiveText),
            )
          : null,
    );
  }

  String _getConditionTitle(String key, String value) {
    if (key.contains('Замер компрессии')) {
      return value.replaceAll(', ', '\n');
    }

    return value;
  }
}
