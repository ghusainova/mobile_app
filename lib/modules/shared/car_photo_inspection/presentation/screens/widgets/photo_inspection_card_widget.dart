import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:image_picker/image_picker.dart';

import '../../../../../../components/styles/app_colors.dart';
import '../../../data/models/photo_inspection_info_item.dart';
import 'camera_nav_btn_widget.dart';
import 'media_thumbnail_widget.dart';
import 'media_title_widget.dart';

class PhotoInspectionCardWidget extends StatefulWidget {
  final PhotoInspectionInfoItem info;
  final Size? cacheSize;
  final double? width;
  final VoidCallback? onDelete;
  final void Function(XFile? filePath)? onCapture;

  const PhotoInspectionCardWidget({
    required this.info,
    super.key,
    this.cacheSize,
    this.width = double.infinity,
    this.onDelete,
    this.onCapture,
  });

  @override
  State<PhotoInspectionCardWidget> createState() =>
      _PhotoInspectionCardWidgetState();
}

class _PhotoInspectionCardWidgetState extends State<PhotoInspectionCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: widget.info.isAdditional && widget.info.iconPath.isNotEmpty,
      badgeContent: const Icon(Icons.close, color: Colors.white, size: 14),
      badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.inactiveText),
      onTap: widget.onDelete,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediaThumbnailWidget(
            imagePath: widget.info.iconPath,
            isVideo: widget.info.isVideoRecording,
            width: widget.width,
            cacheSize: widget.cacheSize,
          ),
          MediaTitleWidget(title: widget.info.title),
          CameraNavBtnWidget(
            hideBtn: widget.onCapture == null,
            onCaptured: onCaptured,
          ),
        ],
      ),
    );
  }

  void onCaptured(XFile? file) {
    if (widget.onCapture != null) {
      widget.onCapture!(file);
    }
  }
}
