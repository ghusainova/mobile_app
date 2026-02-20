import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../components/styles/app_assets.dart';
import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';

class CreditEmptyPlugWidget extends StatelessWidget {
  const CreditEmptyPlugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SvgPicture.asset(AppAssets.emptyCreditIcon),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              'У клиента нет одобренной заявки',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Text(
            'Подберите авто из каталога',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          BlueButton(
            text: 'Начать подбор авто',
            onPressed: () => const CatalogRoute().go(context),
          ),
        ],
      ),
    );
  }
}
