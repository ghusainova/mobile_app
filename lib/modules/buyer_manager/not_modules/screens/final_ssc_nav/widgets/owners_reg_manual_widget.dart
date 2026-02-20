import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';

class OwnersRegManualWidget extends StatelessWidget {
  const OwnersRegManualWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Владелец авто должен передать регистратору:',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColors.inactiveText),
        children: const [
          TextSpan(text: '\n • Приказ'),
          TextSpan(text: '\n • Доверенность'),
          TextSpan(text: '\n • Договор купли продажи'),
        ],
      ),
    );
  }
}
