import 'package:flutter/material.dart';

import '../../../../../../shared/car_inspection/shared/data/models/equipment.dart';
import '../../../../../../../components/widgets/table_content.dart';
import '../hide_show_button.dart';

class EquipmentItemList extends StatefulWidget {
  final Map<String, List<Equipment>> equipmentMap;

  const EquipmentItemList({required this.equipmentMap, super.key});

  @override
  State<EquipmentItemList> createState() => _EquipmentItemListState();
}

class _EquipmentItemListState extends State<EquipmentItemList> {
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    Map<String, List<Equipment>?> croppedEquipment = {
      'Шины и диски': widget.equipmentMap['Шины и диски'],
    };
    Map<String, List<Equipment>?> equipmentMap =
        isShown ? widget.equipmentMap : croppedEquipment;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: equipmentMap.entries.map((entry) {
              return entry.value!.isEmpty
                  ? const SizedBox()
                  : TableContent(entry: entry);
            }).toList(),
          ),
          HideShowButton(
            toggleIsShown: (value) => setState(() => isShown = value),
          ),
        ],
      ),
    );
  }
}
