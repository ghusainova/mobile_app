import 'package:flutter/material.dart';

import '../../widgets/text_field_widget.dart';
import 'checkbox_content_widget.dart';
import 'checkbox_tile_variant_widget.dart';

class RadioButtonTileWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? caption;
  final bool enabled;
  final bool isLastItem;
  final bool prefixBox;
  final bool useCheckBox;
  final EdgeInsets checkBoxPadding;
  final EdgeInsets padding;
  final VoidCallback onTap;
  final void Function(String text)? onCommentChanged;
  final String? Function(String? text)? onValidate;

  const RadioButtonTileWidget({
    required this.title,
    required this.onTap,
    super.key,
    this.subtitle,
    this.caption,
    this.enabled = false,
    this.isLastItem = false,
    this.prefixBox = false,
    this.useCheckBox = false,
    this.checkBoxPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.onCommentChanged,
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    if (useCheckBox) {
      return CheckBoxTileVariantWidget(
        title: title,
        enabled: enabled,
        checkBoxPadding: checkBoxPadding,
        onTap: onTap,
      );
    }

    return Column(
      children: [
        CheckboxContentWidget(
          title: title,
          subtitle: subtitle,
          caption: caption,
          enabled: enabled,
          prefixBox: prefixBox,
          padding: padding,
          onTap: onTap,
        ),
        if (enabled && isLastItem)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFieldWidget(
              labelText: 'Укажите причину',
              maxLines: 3,
              maxLength: 100,
              showCounter: true,
              onTextChanged: onCommentChanged,
              onValidate: onValidate,
            ),
          ),
      ],
    );
  }
}
