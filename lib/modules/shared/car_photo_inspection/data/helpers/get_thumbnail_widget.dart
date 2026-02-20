import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/styles/app_colors.dart';
import '../../../../../components/widgets/cached_image_widget.dart';

Widget getMediaThumbnail(
  String imagePath,
  bool isVideo,
  Size? cacheSize,
) {
  if (imagePath.contains('https')) {
    return CachedImageWidget(
      imagePath,
      width: cacheSize?.width,
      height: cacheSize?.height,
      cacheCoefficient: 1.2,
    );
  } else if (imagePath.isEmpty) {
    return const Icon(
      Icons.file_present,
      color: AppColors.primaryBlue,
    );
  } else if (imagePath.contains('svg')) {
    return SvgPicture.asset(
      imagePath,
      fit: BoxFit.cover,
      colorFilter:
          isVideo ? const ColorFilter.mode(Colors.red, BlendMode.color) : null,
    );
  }

  return Image.asset(imagePath, fit: BoxFit.cover);
}
