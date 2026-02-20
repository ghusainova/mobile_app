import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../../components/widgets/dialog_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../shared/_data/models/auto_info.dart';
import '../../../../../client_processing/domain/qr/qr_bloc.dart';
import '../../../../domain/auto_detail/auto_detail_bloc.dart' as ad;

class SubmitWithoutLoanWidget extends StatelessWidget {
  final bool fromApprovedCredit;

  const SubmitWithoutLoanWidget(this.fromApprovedCredit, {super.key});
  @override
  Widget build(BuildContext context) {
    if (fromApprovedCredit) {
      return const SizedBox();
    }

    return OutlinedBlueButton(
      text: 'Оформить без автокредита',
      showBorder: false,
      margin: const EdgeInsets.only(top: 8),
      onPressed: () => _showAlertWithoutLoan(context),
    );
  }

  void _showAlertWithoutLoan(BuildContext context) {
    final autoInfo = context.read<ad.AutoDetailBloc>().autoInfo;
    final isLoading = getIt.get<QrBloc>().state is Loading;

    if (autoInfo == null) {
      showSnackBar(context, 'Произошла ошибка, перезагрузите страницу');
      return;
    }

    if (isLoading) return;

    showDialog(
      context: context,
      builder: (_) => DialogWidget(
        alertTitle:
            'Вы уверены, что клиент хочет оформить авто без автокредита?',
        submitBtnTitle: 'Да, направить на оформление',
        onSubmit: () => _submitWitoutCarLoan(context, autoInfo),
        onDecline: () => context.pop(),
      ),
    );
  }

  void _submitWitoutCarLoan(BuildContext context, AutoInfo? autoInfo) {
    context.pop();
    showSnackBar(
      context,
      'Перенаправляем клиента, не покидайте страницу...',
      duration: const Duration(seconds: 10),
    );
    getIt.get<QrBloc>().add(ApplyWithoutCarLoan(id: autoInfo?.id));
  }
}
