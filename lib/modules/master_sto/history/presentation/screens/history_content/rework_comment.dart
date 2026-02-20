import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/styles/app_colors.dart';

class ReworkCommentWidget extends StatelessWidget {
  final String? comment;
  final EdgeInsetsGeometry? margin;
  const ReworkCommentWidget({
    super.key,
    required this.comment,
    this.margin = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    if (comment == null || comment == '') {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      margin: margin,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.lightGray,
      ),
      child: ListTile(
        leading: Image.asset(AppAssets.warning),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Замечание:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              comment!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
