import 'package:flutter/material.dart';

import '../../../../../../../../components/widgets/card_widget/card_widget.dart';
import 'defect_subtitle.dart';
import 'video_link.dart';

class DefectTopForm extends StatelessWidget {
  final String bodyType;

  const DefectTopForm({
    required this.bodyType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Осмотрите $bodyType',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const DefectSubtitle(),
          const VideoLink(),
        ],
      ),
    );
  }
}
