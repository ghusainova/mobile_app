import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/table_content.dart';
import '../../../../shared/data/models/equipment.dart';

class EquipmentContent extends StatelessWidget {
  final Map<String, List<Equipment>> equipmentMap;
  const EquipmentContent({required this.equipmentMap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: equipmentMap.entries.map((entry) {
        return CardWidget(
          contentPadding: EdgeInsets.zero,
          margin: const EdgeInsets.only(bottom: 12),
          borderRadius: equipmentMap.entries.first.key == entry.key
              ? CardBorderTypeEnum.onlyBottom
              : CardBorderTypeEnum.all,
          child: TableContent(entry: entry, slim: false),
        );
      }).toList(),
    );
  }
}
