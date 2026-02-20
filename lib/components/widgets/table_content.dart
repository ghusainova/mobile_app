import 'package:flutter/material.dart';

import '../../modules/shared/car_inspection/shared/data/models/equipment.dart';
import '../../modules/sales_manager/auto_detail/presentation/screens/widgets/equipment/detail_subtitle.dart';
import 'table_content_item.dart';

class TableContent extends StatelessWidget {
  final MapEntry<String, List<Equipment>?> entry;
  final bool slim;

  const TableContent({
    required this.entry, super.key,
    this.slim = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailSubtitle(subtitle: entry.key, slim: slim),
        ...(entry.value)!
            .where((element) =>
                element.title.isNotEmpty && element.value.isNotEmpty,)
            .map(
              (item) => TableContentItem(
                title: item.title,
                value: item.value,
                slim: slim,
              ),
            ),
      ],
    );
  }
}
