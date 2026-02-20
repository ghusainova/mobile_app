import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/app_assets.dart';
import '../../styles/app_colors.dart';
import '../buttons/outlined_blue_button.dart';
import 'flushbar_message_widget.dart';

void showSnackBar(
  BuildContext context,
  String? message, {
  Duration? duration,
  bool onTapEnabled = true,
}) {
  if (!context.mounted) {
    return;
  }

  Flushbar(
    icon: SvgPicture.asset(AppAssets.tickIcon),
    flushbarPosition: FlushbarPosition.TOP,
    messageText: FlushbarMessageWidget(message),
    margin: const EdgeInsets.symmetric(horizontal: 16),
    onTap: (_) => _onTap(context, message),
    backgroundColor: AppColors.blackDark,
    duration: duration ?? const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 400),
    borderRadius: BorderRadius.circular(12),
    dismissDirection: FlushbarDismissDirection.VERTICAL,
  ).show(context);
}

void _onTap(BuildContext context, String? text) {
  final message = text ?? 'Произошла ошибка';

  if (!context.mounted) {
    return;
  }

  final dialogWidget = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: 20,
            maxHeight: MediaQuery.of(context).size.height / 2,
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: RawScrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(child: Text(message)),
          ),
        ),
        OutlinedBlueButton(
          text: 'Скопировать',
          slim: true,
          showBorder: false,
          onPressed: () => _copyToClipboard(context, message),
        ),
        OutlinedBlueButton(
          text: 'Закрыть',
          slim: true,
          showBorder: false,
          onPressed: () => _close(context),
        ),
      ],
    ),
  );

  showDialog(context: context, builder: (_) => dialogWidget);
}

void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  _close(context);
}

void _close(BuildContext context) {
  if (context.mounted && Navigator.of(context).canPop()) {
    Navigator.of(context).pop();
  }
}
