import 'package:flutter/material.dart';

import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../../components/styles/app_assets.dart';
import '../../../../_shared/data/models/defect_model.dart';
import 'defect_map_point.dart';

class DefectsMap extends StatelessWidget {
  final List<DefectModel>? defectList;

  const DefectsMap({required this.defectList, super.key});

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
        DefectMapPoint(
          topValue: 0.04,
          leftValue: 0.3,
          defectModel: defectModel(Constants.leftFrontLights),
        ),

        //rightFrontLights
        DefectMapPoint(
          topValue: 0.04,
          leftValue: 0.6,
          defectModel: defectModel(Constants.rightFrontLights),
        ),
        //frontBumper
        DefectMapPoint(
          topValue: 0.02,
          leftValue: 0.45,
          defectModel: defectModel(Constants.frontBumper),
        ),
        //hood
        DefectMapPoint(
          topValue: 0.11,
          leftValue: 0.45,
          defectModel: defectModel(Constants.hood),
        ),
        //windshield
        DefectMapPoint(
          topValue: 0.19,
          leftValue: 0.45,
          defectModel: defectModel(Constants.windshield),
        ),
        //roof
        DefectMapPoint(
          topValue: 0.3,
          leftValue: 0.45,
          defectModel: defectModel(Constants.roof),
        ),
        //backGlass
        DefectMapPoint(
          topValue: 0.405,
          leftValue: 0.45,
          defectModel: defectModel(Constants.backGlass),
        ),
        //trunk
        DefectMapPoint(
          topValue: 0.463,
          leftValue: 0.45,
          defectModel: defectModel(Constants.trunk),
        ),
        //backBumper
        DefectMapPoint(
          topValue: 0.53,
          leftValue: 0.45,
          defectModel: defectModel(Constants.backBumper),
        ),

        //leftBackLights
        DefectMapPoint(
          topValue: 0.45,
          leftValue: 0.3,
          defectModel: defectModel(Constants.leftBackLights),
        ),

        //rightBackLights
        DefectMapPoint(
          topValue: 0.45,
          leftValue: 0.6,
          defectModel: defectModel(Constants.rightBackLights),
        ),

        ///LEFT
        //leftFrontFender
        DefectMapPoint(
          topValue: 0.13,
          leftValue: 0.2,
          defectModel: defectModel(Constants.leftFrontFender),
        ),
        //leftFrontDoor
        DefectMapPoint(
          topValue: 0.23,
          leftValue: 0.15,
          defectModel: defectModel(Constants.leftFrontDoor),
        ),
        //racksSillsLeftFrontDoor
        DefectMapPoint(
          topValue: 0.22,
          leftValue: 0.27,
          defectModel: defectModel(Constants.racksSillsLeftFrontDoor),
        ),
        //leftBackDoor
        DefectMapPoint(
          topValue: 0.32,
          leftValue: 0.15,
          defectModel: defectModel(Constants.leftBackDoor),
        ),
        //racksSillsLeftBackDoor
        DefectMapPoint(
          topValue: 0.36,
          leftValue: 0.28,
          defectModel: defectModel(Constants.racksSillsLeftBackDoor),
        ),
        //leftBackFender
        DefectMapPoint(
          topValue: 0.42,
          leftValue: 0.19,
          defectModel: defectModel(Constants.leftBackFender),
        ),

        ///RIGHT
        //rightFrontFender
        DefectMapPoint(
          topValue: 0.13,
          leftValue: 0.7,
          defectModel: defectModel(Constants.rightFrontFender),
        ),
        //rightFrontDoor
        DefectMapPoint(
          topValue: 0.23,
          leftValue: 0.74,
          defectModel: defectModel(Constants.rightFrontDoor),
        ),
        //racksSillsRightFrontDoor
        DefectMapPoint(
          topValue: 0.22,
          leftValue: 0.62,
          defectModel: defectModel(Constants.racksSillsRightFrontDoor),
        ),
        //rightBackDoor
        DefectMapPoint(
          topValue: 0.32,
          leftValue: 0.74,
          defectModel: defectModel(Constants.rightBackDoor),
        ),
        //racksSillsRightBackDoor
        DefectMapPoint(
          topValue: 0.36,
          leftValue: 0.62,
          defectModel: defectModel(Constants.racksSillsRightBackDoor),
        ),
        //rightBackFender
        DefectMapPoint(
          topValue: 0.42,
          leftValue: 0.7,
          defectModel: defectModel(Constants.rightBackFender),
        ),
      ],
    );
  }

  DefectModel defectModel(String searchType) {
    DefectModel? defectModel = defectList?.firstWhere(
      (DefectModel defect) => defect.bodyPart == searchType,
      orElse: () => const DefectModel(),
    );

    return defectModel ?? const DefectModel();
  }
}
