import 'package:flutter/material.dart';

import '../../../../../../../../components/router/data/routes.dart';
import '../../../../../../../../components/styles/app_colors.dart';

class VideoLink extends StatelessWidget {
  const VideoLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showVideo(context),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.play_circle_outline,
              color: AppColors.buttonBlue,
              size: 18,
            ),
          ),
          Text(
            'Как провести осмотр кузова?',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.buttonBlue),
          ),
        ],
      ),
    );
  }

  void _showVideo(BuildContext context) {
    //TODO: add link after upload video
    const String url = '';
    const VideoPreviewRoute(url).push(context);
  }
}
