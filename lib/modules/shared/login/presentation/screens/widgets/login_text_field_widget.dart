import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/buttons/icon_button_widget.dart';
import '../../../../../../components/widgets/text_field_widget.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onClear;

  const LoginTextField({
    required this.textController,
    required this.onClear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      textController: textController,
      labelText: 'Логин',
      margin: const EdgeInsets.only(top: 24, bottom: 4),
      suffixIcon: IconButtonWidget(
        icon: SvgPicture.asset(AppAssets.clearIcon),
        onTap: onClear,
      ),
    );
  }
}
