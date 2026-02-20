import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../defect_inspection/_shared/data/enum/car_body_part.dart';
import '../../../../equipment_inspection/data/enum/inspection_item_enum.dart';
import '../../../../shared/_helpers/media_capture_args.dart';
import '../../../data/models/phase.dart';
import '../../../domain/history/history_bloc.dart';
import 'history_list.dart';
import 'rework_comment.dart';
import '_buttons/history_nav_btns_widget.dart';
import 'history_title_widget.dart';

class HistoryContent extends StatelessWidget with MediaArgs {
  final bool isFinalStage;

  const HistoryContent({required this.isFinalStage, super.key});

  @override
  Widget build(BuildContext context) {
    final comment = context.read<HistoryBloc>().history?.reworkComment ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HistoryTitleWidget(isFinalStage: isFinalStage),
        ReworkCommentWidget(comment: comment),
        HistoryList(
          isFinalStage: isFinalStage,
          onTap: (phase) => _navigateToStage(phase, context),
        ),
        HistoryNavBtnsWidget(
          isFinalStage: isFinalStage,
          (phase) => _navigateToStage(phase, context),
        ),
      ],
    );
  }

  void _navigateToStage(Phase? phase, BuildContext context) {
    if (phase == null) {
      const MainInfoRoute().push(context);
    } else if (phase.isDefectsRoute) {
      final bodyPart = getBodyPartFromLabel(phase.stageName);
      CarBodyDefectsRoute(bodyPart).push(context);
    } else if (isEquipmentInspectionRoute(phase.imageName)) {
      navigateToInspectionPhase(context, phase.imageName!);
    } else if (phase.isFinalStageRoute) {
      const HistoryRoute(isFinalStage: true).push(context);
    } else if (phase.isVideoVinCapture) {
      VideoCaptureVinRoute(getMasterCaptureArgs()).push(context);
    } else if (phase.isPhotoVinCapture) {
      PhotoCaptureVinRoute(getMasterCaptureArgs()).push(context);
    } else {
      context.push('/${phase.imageName}');
    }
  }
}
