import 'package:flutter/material.dart';

import '../../../../data/models/equipment_inspection.dart';
import '../../../../data/models/inspection_item/inspection_item.dart';
import 'wheels_card_item_widget.dart';

class WheelsTypeWidget extends StatelessWidget {
  final bool isTiresInspection;
  final bool isEqual;
  final EquipmentInspection equipmentInspection;
  final void Function(EquipmentInspection updatedInspection) onChanged;

  const WheelsTypeWidget({
    required this.equipmentInspection, required this.onChanged, super.key,
    this.isTiresInspection = false,
    this.isEqual = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEqual && equipmentInspection.equipments.isNotEmpty) {
      return WheelsCardItemWidget(
        item: equipmentInspection.equipments.first,
        isEqual: isEqual,
        isTiresInspection: isTiresInspection,
        onUpdate: (updatedItem) => _updateValues(null, updatedItem),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: equipmentInspection.equipments.length,
      itemBuilder: (context, index) => WheelsCardItemWidget(
        item: equipmentInspection.equipments[index],
        isEqual: isEqual,
        isTiresInspection: isTiresInspection,
        onUpdate: (updatedItem) => _updateValues(index, updatedItem),
      ),
    );
  }

  void _updateValues(int? index, InspectionItem updatedItem) {
    EquipmentInspection? updatedData;

    if (index != null) {
      updatedData = EquipmentInspection.updateItems(
        equipmentInspection,
        index,
        updatedItem,
      );
    } else {
      updatedData = EquipmentInspection.setEqualItems(
        equipmentInspection,
        updatedItem,
      );
    }

    onChanged(updatedData);
  }
}
