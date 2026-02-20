import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/router/data/routes.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../../client_processing/domain/qr/qr_bloc.dart';
import '../../../../../shared/_data/constants/application_success_configs.dart';
import 'submit_for_approval_widget.dart';
import 'submit_without_loan_widget.dart';

class AutoDetailsButtons extends StatefulWidget {
  final bool fromApprovedCredit;

  const AutoDetailsButtons({
    super.key,
    this.fromApprovedCredit = false,
  });

  @override
  State<AutoDetailsButtons> createState() => _AutoDetailsButtonsState();
}

class _AutoDetailsButtonsState extends State<AutoDetailsButtons> {
  @override
  Widget build(BuildContext context) {
    if (getIt.get<QueueBloc>().activeClient == null) {
      return const SizedBox();
    }

    return BlocProvider.value(
      value: getIt.get<QrBloc>(),
      child: BlocConsumer<QrBloc, QrState>(
        listener: (context, state) => state.whenOrNull(
          success: onSuccess,
          error: onError,
        ),
        builder: (context, state) => CardWidget(
          shadow: true,
          child: Column(
            children: [
              SubmitForApprovalWidget(widget.fromApprovedCredit),
              SubmitWithoutLoanWidget(widget.fromApprovedCredit),
            ],
          ),
        ),
      ),
    );
  }

  void onSuccess() {
    StatusPageRoute(salesManagerConfigs).go(context);
  }

  void onError(String? message) {
    if (mounted) {
      showSnackBar(context, message);
    }
  }
}
