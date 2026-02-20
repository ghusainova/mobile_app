import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/table_content_item.dart';
import '../../../data/models/owner_data.dart';

class OwnerDataFieldsWidget extends StatefulWidget {
  final OwnerData ownerData;

  const OwnerDataFieldsWidget(this.ownerData, {super.key});

  @override
  State<OwnerDataFieldsWidget> createState() => _OwnerDataFieldsWidgetState();
}

class _OwnerDataFieldsWidgetState extends State<OwnerDataFieldsWidget> {
  late final Map<String, String> dataList;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDataListEmpty())
          const Text('Нет данных')
        else
          ...dataList.entries.map(
            (e) => TableContentItem(title: e.key, value: e.value),
          ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlueButton(
              text: 'Продолжить',
              onPressed: () => const CarDataConfirmationRoute().push(context),
            ),
          ),
        ),
      ],
    );
  }

  void initData() {
    dataList = {
      'ФИО владельца': widget.ownerData.client?.firstName ?? '',
      'ИИН владельца': widget.ownerData.client?.iin ?? '',
      'Марка авто': widget.ownerData.auto?.brand ?? '',
      'Год выпуска': widget.ownerData.auto?.year.toString() ?? '',
      'Госномер': widget.ownerData.auto?.stateNumber ?? '',
      'VIN-код': widget.ownerData.auto?.vin ?? '',
    };
  }

  bool isDataListEmpty() {
    dataList.removeWhere((key, value) => value.isEmpty);

    if (dataList.isEmpty) {
      return true;
    }

    return false;
  }
}
