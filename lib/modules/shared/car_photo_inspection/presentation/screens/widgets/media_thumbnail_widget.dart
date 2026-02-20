import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';
import '../../../data/helpers/get_thumbnail_widget.dart';

class MediaThumbnailWidget extends StatelessWidget {
  final String imagePath;
  final bool isVideo;
  final bool isRework;
  final Size? cacheSize;
  final double? width;

  const MediaThumbnailWidget({
    required this.imagePath,
    required this.width,
    super.key,
    this.isVideo = false,
    this.isRework = false,
    this.cacheSize,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () => _showGalleryPreview(context),
        child: Container(
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
              color: isRework ? AppColors.red : AppColors.inactiveText,
              width: isRework ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: getMediaThumbnail(imagePath, isVideo, cacheSize),
          ),
        ),
      ),
    );
  }

  void _showGalleryPreview(BuildContext context) {
    if (!imagePath.contains('http')) {
      return;
    }

    MultiImageProvider multiImageProvider;

    multiImageProvider = MultiImageProvider(
      [NetworkImage(imagePath)],
    );

    showImageViewerPager(context, multiImageProvider);
  }
}
