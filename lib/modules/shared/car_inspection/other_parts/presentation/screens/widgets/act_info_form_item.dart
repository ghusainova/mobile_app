import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/data/models/act_detail.dart';
import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../components/styles/app_colors.dart';

class ActInfoFormItem extends StatelessWidget {
  final ActDetail item;
  const ActInfoFormItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    Widget icon = item.isDefect
        ? SvgPicture.asset(AppAssets.failIcon)
        : SvgPicture.asset(AppAssets.successOutlinedIcon);
    return ListTile(
      leading: icon,
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(
        item.equipment,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        item.condition,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: AppColors.inactiveText),
      ),
    );
  }
}
