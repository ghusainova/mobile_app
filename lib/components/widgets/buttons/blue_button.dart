import 'package:flutter/material.dart';

import '../../styles/app_colors.dart';

class BlueButton extends StatelessWidget {
  final String? text;
  final double verticalPadding;
  final double width;
  final bool isLoading;
  final EdgeInsets margin;
  final void Function() onPressed;

  const BlueButton({
    required this.onPressed,
    super.key,
    this.text,
    this.verticalPadding = 16,
    this.width = double.infinity,
    this.isLoading = false,
    this.margin = const EdgeInsets.only(top: 16),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: margin,
        //TODO: temp fix for resolving button screen overlap issue
        child: ElevatedButton(
          onPressed: _onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: verticalPadding),
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Text(
                  text ?? 'Продолжить',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    height: 1.17,
                  ),
                ),
        ),
        // TextButton(
        //   onPressed: _onTap,
        //   clipBehavior: Clip.antiAlias,
        //   style: TextButton.styleFrom(
        //     padding: EdgeInsets.symmetric(vertical: verticalPadding),
        //     foregroundColor: Colors.white,
        //     backgroundColor: AppColors.primaryBlue,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //   ),

        //   child: isLoading
        //       ? const SizedBox(
        //           width: 20,
        //           height: 20,
        //           child: CircularProgressIndicator(color: Colors.white),
        //         )
        //       : Text(
        //           text ?? 'Продолжить',
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.w500,
        //             fontSize: 16,
        //             height: 1.17,
        //           ),
        //         ),
        // ),
      ),
    );
  }

  void _onTap() {
    if (!isLoading) {
      onPressed();
    }
  }
}
