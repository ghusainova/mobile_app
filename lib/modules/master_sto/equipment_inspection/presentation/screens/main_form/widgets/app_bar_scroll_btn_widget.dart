import 'package:flutter/material.dart';

import '../../../../../../../services/local_storage/system_options/system_options.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../components/widgets/buttons/icon_button_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../../config/injectable/injectable.dart';

class AppBarScrollBtnWidget extends StatelessWidget {
  const AppBarScrollBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      icon: const Icon(
        Icons.auto_awesome_motion,
        color: AppColors.inactiveText,
      ),
      onTap: () => _changeScrollStatus(context),
    );
  }

  Future<void> _changeScrollStatus(BuildContext context) async {
    final systemOptions = getIt.get<SystemOptions>();
    final isEnabled = await systemOptions.changeAutoScrollStatus();

    if (!context.mounted) return;

    if (isEnabled) {
      showSnackBar(context, 'Автоматическа прокрутка включена');
    } else {
      showSnackBar(context, 'Автоматическа прокрутка отключена');
    }
  }
}
