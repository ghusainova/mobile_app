import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../components/widgets/buttons/outlined_blue_button.dart';

class CarNotFoundModal extends StatelessWidget {
  final String? message;

  const CarNotFoundModal(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              message ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const Divider(),
          OutlinedBlueButton(
            text: 'ОК',
            slim: true,
            showBorder: false,
            margin: const EdgeInsets.all(16).copyWith(top: 0),
            padding: EdgeInsets.zero,
            onPressed: () {
              if (context.mounted) context.pop();
            },
          ),
        ],
      ),
    );
  }
}
