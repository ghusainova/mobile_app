import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/styles/app_assets.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';

class ServiceUnavailableWidget extends StatelessWidget {
  final String? message;
  final bool? showCustomMessage;
  final VoidCallback onTap;

  const ServiceUnavailableWidget({
    required this.onTap,
    super.key,
    this.message,
    this.showCustomMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.visitorsIcon),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              'Произошла ошибка',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Text(
            showCustomMessage == true && message != null
                ? message!
                : 'Сервис онлайн очереди временно недоступен',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          BlueButton(text: 'Обновить', onPressed: onTap),
        ],
      ),
    );
  }
}
