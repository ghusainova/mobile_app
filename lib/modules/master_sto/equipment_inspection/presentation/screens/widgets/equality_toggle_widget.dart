import 'package:flutter/material.dart';

import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../components/widgets/switch_list_tile.dart';

class EqualityToggleWidget extends StatelessWidget {
  final bool isEnabled;
  final void Function(bool isEnabled) onChanged;

  const EqualityToggleWidget({
    required this.onChanged,
    super.key,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: AppSwitchListTile(
        text: 'Все колеса одинаковые',
        switchValue: isEnabled,
        contentPadding: EdgeInsets.zero,
        onChanged: onChanged,
      ),
    );
  }
}
