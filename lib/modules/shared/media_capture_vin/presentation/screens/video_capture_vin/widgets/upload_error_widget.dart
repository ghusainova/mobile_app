import 'package:flutter/material.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/outlined_blue_button.dart';

class MediaUploadErrorWidget extends StatelessWidget {
  final VoidCallback onResend;

  const MediaUploadErrorWidget(this.onResend, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Не удалось загрузить файл, попробуйте снова',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.red,
                ),
          ),
          OutlinedBlueButton(
            text: 'Загрузить повторно',
            slim: true,
            enableAlertColorStyle: true,
            margin: const EdgeInsets.only(top: 16),
            onPressed: onResend,
          ),
        ],
      ),
    );
  }
}
