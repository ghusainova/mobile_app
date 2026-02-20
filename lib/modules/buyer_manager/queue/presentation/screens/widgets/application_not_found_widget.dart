import 'package:flutter/material.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../shared/complete_client_session/data/models/completing_reasons_args.dart';
import '../../../../shared/_data/enum/buyer_complete_refused_enum.dart';

class ApplicationNotFoundWidget extends StatelessWidget {
  const ApplicationNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Image.asset(
            AppAssets.emptySearchImage,
            width: 140,
            height: 94,
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Авто на выкуп не найдено',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Найдите заявку по номеру телефона в Kolesa.kz или по номеру объявления',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          BlueButton(
            text: 'Найти заявку',
            onPressed: () => const SearchCaseRoute().push(context),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8.7,
            ),
            alignment: Alignment.bottomCenter,
            child: OutlinedBlueButton(
              text: 'Завершить работу',
              margin: const EdgeInsets.only(top: 24),
              onPressed: () => _onEndWorkWithClient(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onEndWorkWithClient(BuildContext context) {
    final args = CompletingReasonsRouteArgs(
      reasonItems: getBuyerRefusedReasons(),
      onSubmit: () => const BuyerQueueRoute().go(context),
    );

    CompletingReasonsRoute(args).push(context);
  }
}
