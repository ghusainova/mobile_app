import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../sales_manager/auto_detail/data/models/defects.dart';
import 'defect_icons.dart';
import 'defect_point_modal.dart';

class DefectPointWidget extends StatelessWidget {
  final double topValue;
  final double leftValue;
  final TempDefectModel? defectModel;
  final bool onTapEnabled;

  const DefectPointWidget({
    required this.topValue,
    required this.leftValue,
    super.key,
    this.defectModel,
    this.onTapEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final displaySize = MediaQuery.of(context).size;

    if (defectModel == null) {
      return const SizedBox();
    }

    return Container(
      child: defectModel!.isDefect || defectModel!.micrometer.isNotEmpty
          ? SizedBox(
              height: 500,
              child: GestureDetector(
                onTap: () => onTapEnabled ? onTap(context) : null,
                child: Stack(
                  children: [
                    Positioned(
                      top: displaySize.height * (topValue - 0.01),
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
                        child: defectModel?.micrometer != ''
                            ? Text(
                                defectModel!.micrometer,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                              )
                            : null,
                      ),
                    ),
                    if (defectModel!.isDefect)
                      DefectIconsWidgets(
                        topValue: topValue - 0.01,
                        leftValue: leftValue - 0.005,
                        value: defectModel,
                      ),
                  ],
                ),
              ),
            )
          : Positioned(
              top: displaySize.height * (topValue + 0.01),
              left: displaySize.width * (leftValue - 0.025),
              child: SvgPicture.asset(AppAssets.checkedPointIcon),
            ),
    );
  }

  void onTap(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) => BuyerDefectPointModal(
        defectModel: defectModel!,
      ),
    );
  }
}
