import 'package:flutter/material.dart';

import '../../modules/shared/_data/models/auto_info.dart';
import '../../modules/shared/_domain/utility/formatters/upper_case_formatter.dart';

class MainInfoTitleWidget extends StatelessWidget {
  final AutoInfo? autoInfo;
  final double textSize;

  const MainInfoTitleWidget({
    required this.autoInfo,
    required this.textSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${toUpperCase(autoInfo?.auto?.brand)} ${toUpperCase(autoInfo?.auto?.model)}, ${autoInfo?.auto?.year ?? ''}',
      style: TextStyle(
        fontSize: textSize,
        color: Colors.black,
        fontVariations: const [FontVariation('wght', 400)],
      ),
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
