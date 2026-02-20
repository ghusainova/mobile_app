import 'package:flutter/material.dart';

class DetailSubtitle extends StatelessWidget {
  final String subtitle;
  final bool slim;
  const DetailSubtitle({required this.subtitle, super.key, this.slim = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        subtitle,
        style: slim
            ? Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontVariations: [const FontVariation('wght', 500)])
            : Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
