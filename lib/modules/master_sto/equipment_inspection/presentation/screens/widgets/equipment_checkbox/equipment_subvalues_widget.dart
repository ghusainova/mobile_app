import 'package:flutter/material.dart';

import '../../../../../../../components/UI/radio_button_tile/radio_button_tile_widget.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_subvalue.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_value.dart';

class EquipmentSubValuesWidget extends StatelessWidget {
  final InspectionValue value;
  final bool isItemSelected;
  final void Function(List<InspectionSubvalue> updatedSubValues) onChange;

  const EquipmentSubValuesWidget({
    required this.value,
    required this.onChange,
    super.key,
    this.isItemSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (value.subValues.isEmpty ||
        value.isCompressionCheck ||
        value.isPaintwork ||
        !isItemSelected) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 32),
      child: Column(
        children: value.subValues
            .map(
              (e) => RadioButtonTileWidget(
                title: e.name,
                enabled: e.selected,
                prefixBox: true,
                useCheckBox: true,
                checkBoxPadding: const EdgeInsets.only(right: 10),
                onTap: () => _onTap(e),
              ),
            )
            .toList(),
      ),
    );
  }

  void _onTap(InspectionSubvalue subValue) {
    final updatedSubValue = subValue.copyWith(selected: !subValue.selected);
    final updatedSubValuesList = value.subValues
        .map((e) => e == subValue ? updatedSubValue : e)
        .toList();

    onChange(updatedSubValuesList);
  }
}
