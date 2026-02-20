import 'package:flutter/material.dart';

import '../modals/filter_modal.dart';
import 'filter_chip_widget.dart';

class HorizontalFilterWidget extends StatelessWidget {
  const HorizontalFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16, right: 8),
              children: horizontalFilterChips.map((chipInfo) {
                return FilterChipWidget(chipInfo: chipInfo);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
