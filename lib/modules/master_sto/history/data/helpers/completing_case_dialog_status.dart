import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/widgets/dialog_widget.dart';

Future<bool> onCompletingDialog(
  BuildContext context, {
  String title = 'Вы уверены, что хотите завершить осмотр?',
  String submitBtnTitle = 'Завершить',
}) async {
  final isSubmitted = await showDialog(
    context: context,
    builder: (_) => DialogWidget(
      alertTitle: 'Вы уверены, что хотите завершить осмотр?',
      submitBtnTitle: 'Завершить',
      onSubmit: () => context.pop(true),
      onDecline: () => context.pop(),
    ),
  );

  if (isSubmitted == true) {
    return true;
  }

  return false;
}
