import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../shared/complete_client_session/data/models/completing_reasons_args.dart';
import '../../../../shared/_data/enum/buyer_complete_refused_enum.dart';
import '../../../data/enum/buyer_status.dart';
import '../../../domain/buyout/buyout_bloc.dart';

class WorkWithClientBtnsWidget extends StatelessWidget {
  final status = getIt.get<BuyoutBloc>().status;

  WorkWithClientBtnsWidget({
    super.key,
  });

  BuyerStatusEnum? get buyerStatusEnum => status?.buyerStatusEnum;
  bool get showContinueButton =>
      status == null || buyerStatusEnum?.routePath != null;
  bool get showFinishButton =>
      status?.buyerStatusEnum != BuyerStatusEnum.documentsChecked;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 4.5,
      ),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (showContinueButton)
            BlueButton(
              text: 'Начать работу',
              margin: EdgeInsets.zero,
              onPressed: () => _onStartWorkWithClient(context),
            ),
          if (showFinishButton)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: OutlinedBlueButton(
                text: 'Завершить работу',
                showBorder: !showContinueButton,
                onPressed: () => _onEndWorkWithClient(context),
              ),
            ),
        ],
      ),
    );
  }

  void _onStartWorkWithClient(BuildContext context) {
    if (status == null) {
      const CarOwnerConsentRoute().push(context);
    } else if (status?.buyerStatusEnum?.routePath != null) {
      context.push(status!.buyerStatusEnum!.routePath!);
    }

    // const OwnerDataRoute().push(context);
    // const CarInspectionReportRoute().push(context);
    // const FinalSscNavRoute().push(context);
    // const KeyCountSelectionRoute().push(context);
  }

  void _onEndWorkWithClient(BuildContext context) {
    final args = CompletingReasonsRouteArgs(
      reasonItems: getBuyerRefusedReasons(),
      onSubmit: () => const BuyerQueueRoute().go(context),
    );

    CompletingReasonsRoute(args).push(context);
  }
}
