import 'package:flutter/material.dart';

import '../../../../../data/models/inspection_item/inspection_item.dart';
import '../../../../../data/models/inspection_item/inspection_value/inspection_value.dart';
import '../../../widgets/equipment_checkbox/equipment_text_input_widget.dart';
import 'compression_modal.dart';

class CompressionInputWidget extends StatelessWidget {
  final InspectionItem item;
  final void Function(InspectionValue updatedValue) onChange;

  const CompressionInputWidget({
    required this.item, required this.onChange, super.key,
  });

  static List<InspectionValue> sortedValues = [];

  @override
  Widget build(BuildContext context) {
    sortValues();

    return Column(
      children: sortedValues
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(top: 16),
                child: EquipmentTextInputWidget(
                  value: e,
                  labelText: '${e.name}, кг/см2',
                  readOnly: true,
                  digitsOnly: false,
                  forceUpdateTextValue: true,
                  onTap: () => _onTap(context, e),
                ),
              ),)
          .toList(),
    );
  }

  void sortValues() {
    sortedValues.clear();
    sortedValues.addAll(item.values);
    sortedValues.sort((a, b) {
      int aValue =
          int.parse(RegExp(r'\d+').firstMatch(a.name)?.group(0) ?? '0');
      int bValue =
          int.parse(RegExp(r'\d+').firstMatch(b.name)?.group(0) ?? '0');

      return aValue.compareTo(bValue);
    });
  }

  void _onTap(BuildContext context, InspectionValue value) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (_) => CompressionModal(value: value, onChange: onChange),
    );
  }
}
