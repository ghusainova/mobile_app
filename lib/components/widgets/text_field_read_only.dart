import 'package:flutter/material.dart';

import 'text_field_widget.dart';

class TextFieldReadOnly extends StatelessWidget {
  final String? initialText;
  final String? labelText;
  final String? helperText;
  final VoidCallback? onTap;
  final EdgeInsets margin;
  final String? Function(String? text)? onValidate;

  const TextFieldReadOnly({
    this.onTap,
    super.key,
    this.initialText,
    this.labelText,
    this.helperText,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
    this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      readOnly: true,
      margin: margin,
      initialText: initialText,
      labelText: labelText,
      helperText: helperText,
      suffixIcon: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
      onValidate: onValidate,
    );
  }
}
