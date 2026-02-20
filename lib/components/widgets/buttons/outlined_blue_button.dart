import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class OutlinedBlueButton extends StatelessWidget {
  final String text;
  final Widget? leadingIcon;
  final bool slim;
  final bool showBorder;
  final bool enableAlertColorStyle;
  final bool disabled;
  final bool isLoading;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final void Function() onPressed;

  const OutlinedBlueButton({
    required this.onPressed,
    super.key,
    this.text = 'Продолжить',
    this.leadingIcon,
    this.slim = false,
    this.showBorder = true,
    this.enableAlertColorStyle = false,
    this.disabled = false,
    this.isLoading = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: slim ? 32 : 54,
      margin: margin,
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(slim ? 8 : 16),
            side: showBorder
                ? BorderSide(
                    color: enableAlertColorStyle
                        ? AppColors.red.withOpacity(0.3)
                        : disabled
                            ? AppColors.actionSecondary.withOpacity(0.5)
                            : AppColors.actionSecondary,
                    width: 2,
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (leadingIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: leadingIcon,
              ),
            if (isLoading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            else
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: slim ? 14 : 16,
                        color: enableAlertColorStyle
                            ? AppColors.red
                            : disabled
                                ? AppColors.primaryBlue.withOpacity(0.5)
                                : AppColors.primaryBlue,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
