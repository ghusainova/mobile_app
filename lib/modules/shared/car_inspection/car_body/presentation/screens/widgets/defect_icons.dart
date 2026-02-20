import 'package:flutter/material.dart';

import '../../../../../../sales_manager/auto_detail/data/models/defects.dart';

class DefectIconsWidgets extends StatelessWidget {
  final double topValue;
  final double leftValue;
  final TempDefectModel? value;
  const DefectIconsWidgets({
    required this.topValue,
    required this.leftValue,
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (value?.defects == '') {
      return const SizedBox();
    }
    final displaySize = MediaQuery.of(context).size;

    return Positioned(
      top: displaySize.height * (topValue + 0.03),
      left: displaySize.width * (leftValue - 0.02),
      child: Container(
        alignment: Alignment.center,
        width: 36,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (String defect in value!.defects.split(', '))
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
                  defect.isNotEmpty ? defect.substring(0, 1) : '',
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
    );
  }
}
