import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../_shared/data/enum/car_body_part.dart';
import '../../../../_shared/data/models/defect_model.dart';
import 'defect_icons.dart';

class DefectMapPoint extends StatelessWidget {
  final double topValue;
  final double leftValue;
  final DefectModel defectModel;

  const DefectMapPoint({
    required this.topValue,
    required this.leftValue,
    required this.defectModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => _onTap(context),
      child: SizedBox(
        height: 500,
        child: defectModel.hasDefect
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: displaySize.height * (topValue),
                    left: displaySize.width * (leftValue - 0.03),
                    child: Container(
                      alignment: Alignment.center,
                      width: 36,
                      height: 36,
                      decoration: ShapeDecoration(
                        color: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        defectModel.maxMicrometer.isNotEmpty
                            ? defectModel.maxMicrometer
                            : defectModel.averagePaintThickness,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                  DefectIcons(
                    topValue: topValue,
                    leftValue: leftValue - 0.005,
                    defectModel: defectModel,
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned(
                    top: displaySize.height * topValue,
                    left: displaySize.width * (leftValue - 0.025),
                    child: SvgPicture.asset(
                      AppAssets.checkedPointIcon,
                      height: 26,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _onTap(BuildContext context) {
    CarBodyPart bodyPart;
    if (defectModel.bodyPart.contains('Задняя оптика')) {
      bodyPart = CarBodyPart.backLights;
    } else if (defectModel.bodyPart.contains('Противотуманная фара') ||
        defectModel.bodyPart.contains('Передняя оптика')) {
      bodyPart = CarBodyPart.frontLights;
    } else {
      bodyPart = getBodyPartFromLabel(defectModel.bodyPart);
    }
    CarBodyDefectsRoute(bodyPart).push(context);
  }
}
