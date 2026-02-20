import 'package:flutter/material.dart';

import '../../../../../components/router/data/routes.dart';
import '../../../../../components/styles/app_assets.dart';
import '../../../../../components/widgets/car_inspection_list_item.dart';
import '../../../_data/models/auto_info.dart';

class CarInspectionList extends StatelessWidget {
  final AutoInfo? autoInfo;

  const CarInspectionList(this.autoInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        CarInspectionItem(
          icon: AppAssets.equipmentIcon,
          title: 'Опции и оборудование',
          onPressed: () => EquipmentRoute(autoInfo).push(context),
        ),
        CarInspectionItem(
          icon: AppAssets.carBodyIcon,
          title: 'Кузов',
          onPressed: () => CarBodyRoute(autoInfo).push(context),
        ),
        CarInspectionItem(
          icon: AppAssets.interiorIcon,
          title: 'Салон',
          onPressed: () => InteriorRoute(autoInfo).push(context),
        ),
        CarInspectionItem(
          icon: AppAssets.otherPartsIcon,
          title: 'Другие части авто',
          onPressed: () => OtherPartsRoute(autoInfo).push(context),
        ),
      ],
    );
  }
}
