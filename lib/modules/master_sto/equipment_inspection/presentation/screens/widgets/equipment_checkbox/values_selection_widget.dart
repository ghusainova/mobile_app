import 'package:flutter/material.dart';

import '../../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_value.dart';

class ValuesSelectionWidget extends StatelessWidget {
  final InspectionValue value;
  final bool isMultiSelect;
  final VoidCallback onSelect;

  const ValuesSelectionWidget({
    required this.value,
    required this.onSelect,
    super.key,
    this.isMultiSelect = false,
  });

  @override
  Widget build(BuildContext context) {
    if (value.isPaintwork) {
      return const SizedBox();
    }

    return RadioButtonTileWidget(
      title: value.name,
      enabled: value.selected,
      prefixBox: true,
      useCheckBox: isMultiSelect,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      onTap: onSelect,
    );
  }
}
