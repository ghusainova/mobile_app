import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SmallButton({
    required this.onPressed, required this.text, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontVariations: [const FontVariation('wght', 500)],
          ),
        ),
      ),
    );
  }
}
