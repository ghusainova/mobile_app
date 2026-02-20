import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/app_assets.dart';
import '../../router/data/routes.dart';
import '../buttons/icon_button_widget.dart';

class AppbarProfileWidget extends StatelessWidget {
  const AppbarProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      icon: SvgPicture.asset(AppAssets.userIcon),
      onTap: () => const ProfileRoute().push(context),
    );
  }
}
