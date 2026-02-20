import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class RadioButtonWidget extends StatefulWidget {
  final bool initStatus;
  final bool disabled;
  final void Function(bool enabled)? onTap;

  const RadioButtonWidget({
    super.key,
    this.initStatus = false,
    this.disabled = false,
    this.onTap,
  });

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  bool enabled = false;

  Border get border => widget.initStatus || enabled
      ? Border.all(color: AppColors.red, width: 5)
      : Border.all(color: AppColors.borderDark);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.disabled ? null : onTap,
      child: AnimatedContainer(
        width: 20,
        height: 20,
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(shape: BoxShape.circle, border: border),
      ),
    );
  }

  void onTap() {
    setState(() => enabled = !enabled);

    if (widget.onTap != null) {
      widget.onTap!(enabled);
    }
  }
}
