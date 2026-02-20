import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/styles/app_colors.dart';
import '../../../../../../components/widgets/buttons/icon_button_widget.dart';
import '../../../../../../components/widgets/text_field_widget.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController textController;

  const PasswordTextField({
    required this.textController,
    super.key,
  });

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      textController: widget.textController,
      labelText: 'Пароль',
      margin: const EdgeInsets.only(top: 24, bottom: 4),
      obscureText: obscureText,
      suffixIcon: IconButtonWidget(
        icon: SvgPicture.asset(
          AppAssets.eyeIcon,
          colorFilter: obscureText
              ? null
              : const ColorFilter.mode(
                  AppColors.primaryBlue,
                  BlendMode.srcIn,
                ),
        ),
        onTap: onTap,
      ),
    );
  }

  void onTap() {
    if (widget.textController.text.isNotEmpty) {
      setState(() => obscureText = !obscureText);
    }
  }
}
