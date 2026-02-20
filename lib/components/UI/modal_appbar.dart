import 'package:flutter/material.dart';

class ModalAppBar extends StatelessWidget {
  final String text;
  const ModalAppBar({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        text,
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
