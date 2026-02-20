import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../data/models/inspection_item/inspection_item.dart';
import 'tires_dropdown_selection/tires_dropdown_selection_widget.dart';
import '../../widgets/equipment_checkbox/equipment_checkbox_widget.dart';

class WheelsCardItemWidget extends StatefulWidget {
  final InspectionItem item;
  final bool isEqual;
  final bool isTiresInspection;
  final void Function(InspectionItem updatedItem) onUpdate;

  const WheelsCardItemWidget({
    required this.item,
    required this.isEqual,
    required this.isTiresInspection,
    required this.onUpdate,
    super.key,
  });

  @override
  State<WheelsCardItemWidget> createState() => _WheelsCardItemWidgetState();
}

class _WheelsCardItemWidgetState extends State<WheelsCardItemWidget> {
  late final InspectionItem item;

  @override
  void initState() {
    super.initState();
    mapFields();
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      title: widget.isEqual ? null : item.name,
      contentPadding:
          widget.isEqual ? EdgeInsets.zero : const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(top: 16),
      child: widget.isTiresInspection
          ? TireDropdownSelectionWidget(
              item: item,
              isMultiSelect: item.multiSelect,
              onChanged: (updatedItem) => widget.onUpdate(updatedItem),
            )
          : EquipmentCheckboxWidget(
              item: item,
              onChanged: (updatedItem) => widget.onUpdate(updatedItem),
            ),
    );
  }

  void mapFields() {
    final reversedValues = widget.item.values.reversed.toList();
    item = widget.item.copyWith(values: reversedValues);
  }
}
