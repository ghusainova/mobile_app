import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final String title;
  final Widget child;
  const ContainerWidget({required this.title, required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        child,
      ],
    );
  }
}
