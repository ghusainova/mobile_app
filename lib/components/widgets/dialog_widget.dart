import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'buttons/outlined_blue_button.dart';

class DialogWidget extends StatefulWidget {
  final String alertTitle;
  final String? alertSubTitle;
  final String submitBtnTitle;
  final String declineBtnTitle;
  final VoidCallback? onSubmit;
  final VoidCallback? onDecline;

  const DialogWidget({
    required this.alertTitle, super.key,
    this.alertSubTitle,
    this.submitBtnTitle = 'Ок',
    this.declineBtnTitle = 'Отмена',
    this.onSubmit,
    this.onDecline,
  });

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width / 1.5,
          minHeight: MediaQuery.of(context).size.height / 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: widget.alertSubTitle != null
                  ? const EdgeInsets.fromLTRB(16, 16, 16, 0)
                  : const EdgeInsets.all(16),
              child: Text(
                widget.alertTitle,
                maxLines: 3,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (widget.alertSubTitle != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  widget.alertSubTitle!,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.inactiveText),
                ),
              ),
            if (widget.onSubmit != null)
              OutlinedBlueButton(
                text: widget.submitBtnTitle,
                showBorder: false,
                onPressed: widget.onSubmit!,
              ),
            if (widget.onDecline != null)
              OutlinedBlueButton(
                text: widget.declineBtnTitle,
                showBorder: false,
                onPressed: widget.onDecline!,
              ),
          ],
        ),
      ),
    );
  }
}
