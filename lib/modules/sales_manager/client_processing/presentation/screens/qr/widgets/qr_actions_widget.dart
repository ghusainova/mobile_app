import 'package:flutter/material.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../shared/_data/models/auto_info.dart';
import '../../../../../shared/_data/enum/sales_completing_types.dart';
import '../../../../domain/qr/qr_bloc.dart';

class QrActionsWidget extends StatelessWidget {
  final AutoInfo autoInfo;

  const QrActionsWidget(this.autoInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: BlueButton(
            text: 'Направить на оформление',
            onPressed: () => _submitForProcessing(context),
          ),
        ),
        OutlinedBlueButton(
          text: 'Завершить работу с клиентом',
          showBorder: false,
          onPressed: () => _completeClientSession(context),
        ),
      ],
    );
  }

  void _submitForProcessing(BuildContext context) {
    showSnackBar(
      context,
      'Перенаправляем клиента, не покидайте страницу...',
      duration: const Duration(seconds: 5),
    );
    getIt.get<QrBloc>().add(
          GetApprovalForCarLoan(
            id: autoInfo.id,
            advertLink: autoInfo.linkSell,
          ),
        );
  }

  void _completeClientSession(BuildContext context) {
    final salesCompletingTypes = getSalesCompletingTypes();
    CompletingTypeSelectionRoute(salesCompletingTypes).push(context);
  }
}
