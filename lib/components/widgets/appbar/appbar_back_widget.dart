import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../styles/app_assets.dart';
import '../buttons/icon_button_widget.dart';

class AppbarBackWidget extends StatelessWidget {
  final Widget? customIcon;
  final void Function()? onPressed;

  const AppbarBackWidget({
    super.key,
    this.customIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      icon: customIcon ??
          SvgPicture.asset(
            AppAssets.arrowBackIcon,
            width: 20,
            height: 15,
          ),
      onTap: () => _onBack(context),
    );
  }

  void _onBack(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
    } else if (context.mounted && context.canPop()) {
      context.pop();
    }
  }
}
