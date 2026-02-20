import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/dialog_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../shared/_data/models/auto_info.dart';
import '../../../../../client_processing/domain/qr/qr_bloc.dart';
import '../../../../domain/auto_detail/auto_detail_bloc.dart' as adb;

class SubmitForApprovalWidget extends StatelessWidget {
  final bool fromApprovedCredit;

  const SubmitForApprovalWidget(this.fromApprovedCredit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlueButton(
      text: fromApprovedCredit
          ? 'Направить на оформление'
          : 'Получить одобрение на автокредит',
      margin: EdgeInsets.zero,
      onPressed: () => _showAlertApprovedCredit(context),
    );
  }

  void _showAlertApprovedCredit(BuildContext context) {
    final autoInfo = context.read<adb.AutoDetailBloc>().autoInfo;
    final isLoading = getIt.get<QrBloc>().state is Loading;

    if (autoInfo == null) {
      showSnackBar(context, 'Произошла ошибка, перезагрузите страницу');
      return;
    }

    if (isLoading) return;

    if (fromApprovedCredit) {
      final auto = autoInfo.auto;

      showDialog(
        context: context,
        builder: (_) => DialogWidget(
          alertTitle:
              'Направить клиента на оформление ${auto?.brand ?? ''} ${auto?.model ?? ''}, ${auto?.year ?? ''}? ',
          submitBtnTitle: 'Да, направить на оформление',
          onSubmit: () => _submitForApproval(context, autoInfo),
          onDecline: () => context.pop(),
        ),
      );
    } else {
      QrRoute(autoInfo).push(context);
    }
  }

  void _submitForApproval(BuildContext context, AutoInfo? autoInfo) {
    context.pop();
    showSnackBar(
      context,
      'Перенаправляем клиента, не покидайте страницу...',
      duration: const Duration(seconds: 10),
    );
    getIt.get<QrBloc>().add(
          GetApprovalForCarLoan(
            id: autoInfo?.id,
            advertLink: autoInfo?.linkSell,
          ),
        );
  }
}
