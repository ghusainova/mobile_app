import 'package:flutter/material.dart';

import '../../../../../shared/_domain/utility/formatters/upper_case_formatter.dart';
import '../../../../../../components/widgets/page_form_widget.dart';
import '../../../../../shared/_data/models/auto_info.dart';
import '../../../../../shared/car_inspection/shared/presentation/car_inspection_list.dart';

class CarInspectionPage extends StatelessWidget {
  final AutoInfo? autoInfo;
  const CarInspectionPage({required this.autoInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return PageFormWidget(
      appBarTitle: 'Акт осмотра авто',
      pageTitle:
          'Акт осмотра ${toUpperCase(autoInfo?.auto?.brand)} \n${toUpperCase(autoInfo?.auto?.model)}, ${autoInfo?.auto?.year ?? ''}',
      child: CarInspectionList(autoInfo),
    );
  }
}
