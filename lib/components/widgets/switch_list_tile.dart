import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppSwitchListTile extends StatefulWidget {
  final String text;
  final bool switchValue;
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final void Function(bool value)? onChanged;

  const AppSwitchListTile({
    required this.text, super.key,
    this.switchValue = false,
    this.margin = EdgeInsets.zero,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 8),
    this.onChanged,
  });

  @override
  State<AppSwitchListTile> createState() => _AppSwitchListTileState();
}

class _AppSwitchListTileState extends State<AppSwitchListTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: SwitchListTile(
        contentPadding: widget.contentPadding,
        activeColor: Colors.white,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: AppColors.lightGray,
        activeTrackColor: AppColors.red,
        title: Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        value: widget.switchValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
