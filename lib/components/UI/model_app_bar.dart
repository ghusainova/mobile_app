import 'package:flutter/material.dart';

class ModelAppBar extends StatelessWidget {
  final String brand;
  const ModelAppBar({required this.brand, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        brand,
        style: Theme.of(context).textTheme.displayLarge,
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
      ),
    );
  }
}
