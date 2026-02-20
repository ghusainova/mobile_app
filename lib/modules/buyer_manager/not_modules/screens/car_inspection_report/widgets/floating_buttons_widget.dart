import 'package:flutter/material.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../master_sto/history/data/helpers/completing_case_dialog_status.dart';
import '../../../../../shared/complete_client_session/data/models/completing_reasons_args.dart';
import '../../../../queue/data/enum/buyer_status.dart';
import '../../../../queue/domain/buyout/buyout_bloc.dart';
import '../../../../shared/_data/enum/buyer_complete_refused_enum.dart';
import '../../../../shared/_data/repositories/buyout_shared_repository.dart';

class FloatingButtonsWidget extends StatefulWidget {
  const FloatingButtonsWidget({super.key});

  @override
  State<FloatingButtonsWidget> createState() => _FloatingButtonsWidgetState();
}

class _FloatingButtonsWidgetState extends State<FloatingButtonsWidget> {
  final status = getIt.get<BuyoutBloc>().status;
  bool isLoading = false;

  bool get readyToBuy => status?.buyerStatusEnum == BuyerStatusEnum.readyToBuy;
  bool get readyToBuyIf =>
      (status?.buyerStatusEnum?.name ?? '').contains('Нужно');
  bool get showButtons => readyToBuy || readyToBuyIf;

  @override
  Widget build(BuildContext context) {
    if (!showButtons) {
      return const SizedBox();
    }

    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyTop,
      shadow: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: readyToBuy
            ? Column(
                children: [
                  BlueButton(
                    text: 'Владелец согласен продать авто',
                    margin: EdgeInsets.zero,
                    onPressed: () {},
                  ),
                  OutlinedBlueButton(
                    text: 'Владелец не согласен продать авто',
                    margin: const EdgeInsets.only(top: 16),
                    showBorder: false,
                    onPressed: () => _navigateToComplete(context),
                  ),
                ],
              )
            : BlueButton(
                text: 'Завершить работу',
                isLoading: isLoading,
                onPressed: handleFinishWork,
              ),
      ),
    );
  }

  void _navigateToComplete(BuildContext context) {
    final args = CompletingReasonsRouteArgs(
      reasonItems: getBuyerRefusedReasons(),
      onSubmit: () => const BuyerQueueRoute().go(context),
    );

    CompletingReasonsRoute(args).push(context);
  }

  void handleFinishWork() async {
    final isSubmitted = await onCompletingDialog(
      context,
      title: 'Вы уверены, что хотите завершить работу?',
      submitBtnTitle: 'Да, завершить работу',
    );

    if (isSubmitted) {
      finishWork();
    }
  }

  void finishWork() async {
    setState(() => isLoading = true);
    bool isFinished = await getIt
        .get<BuyoutSharedRepository>()
        .finishWork(getIt.get<BuyoutBloc>().autoInfo?.id);
    if (!mounted) {
      return;
    }

    if (isFinished) {
      const BuyerQueueRoute().go(context);
    } else {
      setState(() => isLoading = false);
      showSnackBar(context, 'Не удалось завершить работу');
    }
  }
}
