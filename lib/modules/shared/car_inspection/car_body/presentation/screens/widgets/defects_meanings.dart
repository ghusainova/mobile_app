import 'package:flutter/material.dart';

import '../../../../../_data/constants/global_constants.dart';
import 'defects_meanings_item.dart';

class DefectsMeanings extends StatelessWidget {
  final bool isBuyout;
  const DefectsMeanings({required this.isBuyout, super.key});

  List<String> get defectsMeanings => isBuyout
      ? Constants.buyerInspectionDefects
      : Constants.salesInspectionDefects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Обозначения дефектов',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Wrap(
            runSpacing: 8,
            children: defectsMeanings
                .map((defect) => DefectMeaningsItem(defect: defect))
                .toList(),
          ),
        ),
      ],
    );
  }
}
