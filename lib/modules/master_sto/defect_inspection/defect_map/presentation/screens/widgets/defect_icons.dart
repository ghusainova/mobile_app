import 'package:flutter/material.dart';

import '../../../../_shared/data/models/defect_model.dart';

class DefectIcons extends StatelessWidget {
  final double topValue;
  final double leftValue;
  final DefectModel defectModel;
  const DefectIcons({
    required this.topValue,
    required this.leftValue,
    required this.defectModel,
    super.key,
  });

  List<String> getUniqueDefectNames(DefectModel defectModel) {
    final defectList = defectModel.defects ?? [];
    return defectList
        .expand((defect) => defect.values)
        .where((value) => value.status)
        .map((value) => value.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;
    final defectsList = getUniqueDefectNames(defectModel);
    return (defectsList.isNotEmpty)
        ? Positioned(
            top: displaySize.height * (topValue + 0.03),
            left: displaySize.width * (leftValue - 0.02),
            child: Container(
              alignment: Alignment.center,
              width: 36,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (String defect in defectsList)
                    Container(
                      width: 16,
                      height: 16,
                      padding: const EdgeInsets.all(2),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Colors.black.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        defect,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 10),
                      ),
                    ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
