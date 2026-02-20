import 'package:flutter/material.dart';

class VideoCaptureTitleWidget extends StatelessWidget {
  const VideoCaptureTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Text(
            'Запишите видео VIN-кода',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Text(
          'Запишите видео выбитого VIN-кода. Если выбитого VIN-кода нет, запишите видео VIN на лобовом стекле.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
