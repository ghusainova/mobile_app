import 'package:flutter/material.dart';

class MediaTitleWidget extends StatelessWidget {
  final String title;

  const MediaTitleWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (title.isEmpty) return const SizedBox();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
