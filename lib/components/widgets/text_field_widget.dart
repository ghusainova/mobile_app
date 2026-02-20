import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_colors.dart';
import '../../modules/shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../modules/shared/_domain/utility/formatters/uppercase_text_formatter.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? textController;
  final String? initialText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final EdgeInsets margin;
  final EdgeInsets? contenPadding;
  final int maxLines;
  final int? maxLength;
  final bool autofocus;
  final bool obscureText;
  final bool showCounter;
  final bool noFilling;
  final bool readOnly;
  final bool enableInteractiveSelection;
  final bool usePriceFormatter;
  final bool upperCaseFormatter;
  final bool digitsOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String? text)? onValidate;
  final void Function(String text)? onTextChanged;
  final void Function(String text)? onEditingComplete;
  final VoidCallback? onTap;

  const TextFieldWidget({
    super.key,
    this.textController,
    this.initialText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.margin = EdgeInsets.zero,
    this.contenPadding,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.obscureText = false,
    this.showCounter = false,
    this.noFilling = false,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.usePriceFormatter = false,
    this.upperCaseFormatter = false,
    this.digitsOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onValidate,
    this.onTextChanged,
    this.onEditingComplete,
    this.onTap,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController textController;

  String get maxTextLength =>
      widget.maxLength != null ? '/${widget.maxLength}' : '';

  int currentTextLength = 0;

  @override
  void initState() {
    super.initState();
    textController = widget.textController ?? TextEditingController();
    applyInitialData();
    textListener();
  }

  @override
  void didUpdateWidget(TextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    applyInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: TextFormField(
        enableInteractiveSelection: widget.enableInteractiveSelection,
        controller: textController,
        autofocus: widget.autofocus,
        obscureText: widget.obscureText,
        style: Theme.of(context).textTheme.bodyLarge,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        readOnly: widget.readOnly,
        scrollPadding: const EdgeInsets.only(bottom: 140),
        keyboardType: widget.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          helperText: widget.helperText,
          labelText: widget.labelText,
          errorText: widget.errorText,
          alignLabelWithHint: widget.maxLines > 1,
          filled: true,
          fillColor: widget.noFilling ? Colors.white : AppColors.lightGray,
          border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: AppColors.primaryBlue, width: 6),
          ),
          errorBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: AppColors.red, width: 6),
          ),
          contentPadding: widget.contenPadding ??
              const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          counterText:
              widget.showCounter ? '$currentTextLength$maxTextLength' : null,
        ),
        inputFormatters: [
          if (widget.usePriceFormatter) PriceInputFormatter(),
          if (widget.upperCaseFormatter) UpperCaseTextFormatter(),
          if (widget.digitsOnly) FilteringTextInputFormatter.digitsOnly,
        ],
        autovalidateMode: widget.onValidate != null
            ? AutovalidateMode.onUserInteraction
            : null,
        validator: widget.onValidate,
        onChanged: widget.onTextChanged,
        onEditingComplete: onEditingComplete,
        onTap: widget.readOnly && widget.onTap != null ? widget.onTap : null,
      ),
    );
  }

  void textListener() {
    textController.addListener(() {
      if (widget.showCounter && mounted) {
        setState(() => currentTextLength = textController.text.length);
      }
    });
  }

  void onEditingComplete() {
    FocusScope.of(context).unfocus();

    if (widget.onEditingComplete != null) {
      widget.onEditingComplete!(textController.text);
    }
  }

  void applyInitialData() {
    if (widget.textController == null && widget.initialText != null) {
      textController.text = widget.initialText ?? '';
    }
  }
}
