import 'package:flutter/material.dart';

import '../../../../data/models/inspection_item/inspection_value/inspection_subvalue.dart';
import '../../../../data/models/inspection_item/inspection_value/inspection_value.dart';
import '../../widgets/equipment_checkbox/equipment_text_input_widget.dart';

class PaintThicknessInputWidget extends StatelessWidget {
  final InspectionValue? value;
  final void Function(InspectionValue updatedValue) onChange;

  const PaintThicknessInputWidget({
    required this.value, required this.onChange, super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || !(value?.isPaintwork ?? false)) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      child: EquipmentTextInputWidget(
        value: value!,
        labelText: 'Максимальная толщина ЛКП, мкм',
        onChange: _onChange,
      ),
    );
  }

  void _onChange(String? text) {
    List<InspectionSubvalue> subValues = [];

    if ((text ?? '').isNotEmpty) {
      subValues = [InspectionSubvalue(name: text!, selected: true)];
    } else {
      subValues = [];
    }

    final updatedValue = value!.copyWith(subValues: subValues);
    onChange(updatedValue);
  }
}
