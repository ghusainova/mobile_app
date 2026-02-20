import 'package:flutter/material.dart';

import '../../../../../../../components/widgets/car_inspection_list_item.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../data/models/scan_case.dart';

class FilteredCasesList extends StatelessWidget {
  final void Function(ScanCase) onPressed;

  final List<ScanCase> cases;
  const FilteredCasesList({
    required this.cases,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cases.length,
      itemBuilder: (context, index) {
        final e = cases[index];
        return CardWidget(
          margin: const EdgeInsets.only(top: 16),
          child: CarInspectionItem(
            title: '${e.brand} ${e.model}',
            subtitle: '${e.stateNumber} • ${e.clientName}',
            onPressed: () => onPressed(e),
          ),
        );
      },
    );
  }
}
