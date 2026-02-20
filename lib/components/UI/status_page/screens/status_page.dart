import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../modules/shared/_data/enums/status_type_enum.dart';
import '../../../../modules/buyer_manager/shared/_data/models/status_page_configs.dart';
import '../../../widgets/animated_status_icon.dart';
import '../../../widgets/appbar/appbar_widget.dart';
import '../../../widgets/buttons/blue_button.dart';

class StatusPage extends StatelessWidget {
  final StatusPageConfigs configs;

  const StatusPage({
    required this.configs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(configs.appBarTitle, showBackButton: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedStatusIcon(
                  iconData: configs.statusType.icon,
                  color: configs.statusType == StatusTypeEnum.info
                      ? configs.statusType.bgColor
                      : configs.statusType.iconColor,
                  size: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: Text(
                    configs.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                if (configs.subtitle != null)
                  Text(
                    configs.subtitle!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
              ],
            ),
          ),
          BlueButton(
            text: configs.buttonText,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 42),
            onPressed: () => _onPressed(context),
          ),
        ],
      ),
    );
  }

  void _onPressed(BuildContext context) {
    if (configs.onPressed != null) {
      configs.onPressed;
    }
    context.go(configs.routePath);
  }
}
