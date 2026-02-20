import 'package:flutter/material.dart';

import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../_data/constants/global_constants.dart';
import '../../../../../../sales_manager/auto_detail/data/models/defects.dart';
import 'defect_point.dart';

class DefectsMap extends StatelessWidget {
  final List<TempDefectModel>? defects;
  final bool onTapEnabled;

  const DefectsMap({
    required this.defects,
    super.key,
    this.onTapEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          alignment: Alignment.center,
          fit: BoxFit.fitWidth,
          height: MediaQuery.of(context).size.height / 1.7,
          image: const AssetImage(AppAssets.carBodyMapImage),
        ),

        ///CENTER
        //leftFrontLights
        DefectPointWidget(
          topValue: 0.04,
          leftValue: 0.3,
          defectModel: defectModel(Constants.leftFrontLights),
          onTapEnabled: onTapEnabled,
        ),

        //rightFrontLights
        DefectPointWidget(
          topValue: 0.04,
          leftValue: 0.6,
          defectModel: defectModel(Constants.rightFrontLights),
          onTapEnabled: onTapEnabled,
        ),
        //frontBumper
        DefectPointWidget(
          topValue: 0.02,
          leftValue: 0.45,
          defectModel: defectModel(Constants.frontBumper),
          onTapEnabled: onTapEnabled,
        ),
        //hood
        DefectPointWidget(
          topValue: 0.11,
          leftValue: 0.45,
          defectModel: defectModel(Constants.hood),
          onTapEnabled: onTapEnabled,
        ),
        //windshield
        DefectPointWidget(
          topValue: 0.19,
          leftValue: 0.45,
          defectModel: defectModel(Constants.windshield),
          onTapEnabled: onTapEnabled,
        ),
        //roof
        DefectPointWidget(
          topValue: 0.3,
          leftValue: 0.45,
          defectModel: defectModel(Constants.roof),
          onTapEnabled: onTapEnabled,
        ),
        //backGlass
        DefectPointWidget(
          topValue: 0.405,
          leftValue: 0.45,
          defectModel: defectModel(Constants.backGlass),
          onTapEnabled: onTapEnabled,
        ),
        //trunk
        DefectPointWidget(
          topValue: 0.463,
          leftValue: 0.45,
          defectModel: defectModel(Constants.trunk),
          onTapEnabled: onTapEnabled,
        ),
        //backBumper
        DefectPointWidget(
          topValue: 0.53,
          leftValue: 0.45,
          defectModel: defectModel(Constants.backBumper),
          onTapEnabled: onTapEnabled,
        ),

        //leftBackLights
        DefectPointWidget(
          topValue: 0.45,
          leftValue: 0.3,
          defectModel: defectModel(Constants.leftBackLights),
          onTapEnabled: onTapEnabled,
        ),

        //rightBackLights
        DefectPointWidget(
          topValue: 0.45,
          leftValue: 0.6,
          defectModel: defectModel(Constants.rightBackLights),
          onTapEnabled: onTapEnabled,
        ),

        ///LEFT
        //leftFrontFender
        DefectPointWidget(
          topValue: 0.13,
          leftValue: 0.2,
          defectModel: defectModel(Constants.leftFrontFender),
          onTapEnabled: onTapEnabled,
        ),
        //leftFrontDoor
        DefectPointWidget(
          topValue: 0.23,
          leftValue: 0.15,
          defectModel: defectModel(Constants.leftFrontDoor),
          onTapEnabled: onTapEnabled,
        ),
        //racksSillsLeftFrontDoor
        DefectPointWidget(
          topValue: 0.22,
          leftValue: 0.27,
          defectModel: defectModel(Constants.racksSillsLeftFrontDoor),
          onTapEnabled: onTapEnabled,
        ),
        //leftBackDoor
        DefectPointWidget(
          topValue: 0.32,
          leftValue: 0.15,
          defectModel: defectModel(Constants.leftBackDoor),
          onTapEnabled: onTapEnabled,
        ),
        //racksSillsLeftBackDoor
        DefectPointWidget(
          topValue: 0.36,
          leftValue: 0.28,
          defectModel: defectModel(Constants.racksSillsLeftBackDoor),
          onTapEnabled: onTapEnabled,
        ),
        //leftBackFender
        DefectPointWidget(
          topValue: 0.42,
          leftValue: 0.19,
          defectModel: defectModel(Constants.leftBackFender),
          onTapEnabled: onTapEnabled,
        ),

        ///RIGHT
        //rightFrontFender
        DefectPointWidget(
          topValue: 0.13,
          leftValue: 0.7,
          defectModel: defectModel(Constants.rightFrontFender),
          onTapEnabled: onTapEnabled,
        ),
        //rightFrontDoor
        DefectPointWidget(
          topValue: 0.23,
          leftValue: 0.74,
          defectModel: defectModel(Constants.rightFrontDoor),
          onTapEnabled: onTapEnabled,
        ),
        //racksSillsRightFrontDoor
        DefectPointWidget(
          topValue: 0.22,
          leftValue: 0.62,
          defectModel: defectModel(Constants.racksSillsRightFrontDoor),
          onTapEnabled: onTapEnabled,
        ),
        //rightBackDoor
        DefectPointWidget(
          topValue: 0.32,
          leftValue: 0.74,
          defectModel: defectModel(Constants.rightBackDoor),
          onTapEnabled: onTapEnabled,
        ),
        //racksSillsRightBackDoor
        DefectPointWidget(
          topValue: 0.36,
          leftValue: 0.62,
          defectModel: defectModel(Constants.racksSillsRightBackDoor),
          onTapEnabled: onTapEnabled,
        ),
        //rightBackFender
        DefectPointWidget(
          topValue: 0.42,
          leftValue: 0.7,
          defectModel: defectModel(Constants.rightBackFender),
          onTapEnabled: onTapEnabled,
        ),
      ],
    );
  }

  TempDefectModel? defectModel(String searchType) {
    TempDefectModel? defectModel = defects?.firstWhere(
      (TempDefectModel defect) => defect.title == searchType,
      orElse: () => const TempDefectModel(),
    );

    return defectModel;
  }
}
