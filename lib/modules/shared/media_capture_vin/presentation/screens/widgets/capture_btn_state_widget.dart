import 'package:flutter/material.dart';

import '../../../../../../components/styles/app_colors.dart';

class MediaCaptureBtnStateWidget extends StatelessWidget {
  final bool isLoading;
  final bool small;
  final bool hasVideo;

  const MediaCaptureBtnStateWidget({
    required this.isLoading,
    required this.hasVideo,
    super.key,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasVideo) {
      return const Icon(
        Icons.play_circle_outline,
        color: AppColors.primaryBlue,
        size: 40,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.camera_alt,
          color: AppColors.primaryBlue,
          size: small ? 20 : null,
        ),
        if (!small)
          Text(
            'Открыть камеру',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.primaryBlue),
          ),
      ],
    );
  }
}
