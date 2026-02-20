import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';
import '../../widgets/radio_button_widget.dart';

class CheckboxContentWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? caption;
  final bool enabled;
  final bool prefixBox;
  final EdgeInsets padding;
  final VoidCallback onTap;

  const CheckboxContentWidget({
    required this.title, required this.enabled, required this.prefixBox, required this.padding, required this.onTap, super.key,
    this.subtitle,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: prefixBox
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              if (!prefixBox)
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: RadioButtonWidget(
                    initStatus: enabled,
                    disabled: true,
                  ),
                ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          subtitle!,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.inactiveText),
                        ),
                      ),
                    if (caption != null) caption!,
                  ],
                ),
              ),
              if (prefixBox)
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: RadioButtonWidget(initStatus: enabled, disabled: true),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
