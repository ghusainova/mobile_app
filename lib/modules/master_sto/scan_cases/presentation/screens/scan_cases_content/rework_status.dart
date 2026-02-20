import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';

class ReworkStatus extends StatelessWidget {
  const ReworkStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.lightRed,
      ),
      child: Text(
        'Авто вернулось на доработку',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.red,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
