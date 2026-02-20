import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:image_picker/image_picker.dart';

import '../../../../../../../components/styles/app_colors.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/car_photo_inspection/presentation/screens/widgets/camera_nav_btn_widget.dart';
import '../../../../../../shared/car_photo_inspection/presentation/screens/widgets/media_thumbnail_widget.dart';
import '../../../../../../shared/car_photo_inspection/presentation/screens/widgets/media_title_widget.dart';
import '../../../../../credit_rework/domain/credit_rework/credit_rework_bloc.dart';
import '../../../../data/models/credit_photo_inspection_info_item.dart';

class CreditPhotoInspectionCardWidget extends StatelessWidget {
  final CreditPhotoInspectionInfoItem info;
  final Size? cacheSize;
  final double? width;
  final bool isLoading;
  final VoidCallback? onDelete;
  final void Function(XFile? filePath)? onCapture;

  const CreditPhotoInspectionCardWidget({
    required this.info,
    super.key,
    this.cacheSize,
    this.width = double.infinity,
    this.isLoading = false,
    this.onDelete,
    this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: info.isAdditional && info.imagePath.isNotEmpty,
      badgeContent: const Icon(Icons.close, color: Colors.white, size: 14),
      badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.inactiveText),
      onTap: onDelete,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediaThumbnailWidget(
            imagePath: info.imagePath,
            width: width,
            cacheSize: cacheSize,
            isRework:
                getIt.get<CreditReworkBloc>().isReworkImage(info.imagePath),
          ),
          MediaTitleWidget(title: info.title),
          CameraNavBtnWidget(
            hideBtn: onCapture == null,
            isLoading: isLoading,
            onCaptured: onCaptured,
          ),
        ],
      ),
    );
  }

  void onCaptured(XFile? file) {
    if (onCapture != null && file != null) {
      onCapture!(file);
    }
  }
}
