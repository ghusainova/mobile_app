import 'package:flutter/material.dart';

class FlushbarMessageWidget extends StatelessWidget {
  final String? message;

  const FlushbarMessageWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      (message ?? '').isNotEmpty ? message! : 'Произошла ошибка',
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        color: Colors.white,
        fontVariations: [const FontVariation('wght', 500)],
      ),
    );
  }
}
