import 'package:flutter/material.dart';

class DefectListSubtitle extends StatelessWidget {
  final String subtitle;
  const DefectListSubtitle({required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        subtitle,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
