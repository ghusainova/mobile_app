import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class NumericKeyWidget extends StatelessWidget {
  final String text;

  const NumericKeyWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      margin: const EdgeInsets.only(right: 12),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
