import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../domain/credit_application/credit_application_bloc.dart';
import 'credit_application_content_widget.dart';
import 'credit_application_loading_widget.dart';
import 'no_approved_application.dart';

class CreditApplicationWidget extends StatelessWidget {
  const CreditApplicationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<CreditApplicationBloc>(),
      child: BlocConsumer<CreditApplicationBloc, CreditApplicationState>(
        listener: (context, state) {
          state.whenOrNull(
            noContent: (message) => showSnackBar(context, message),
            showMessage: (message) => showSnackBar(context, message),
          );
        },
        builder: (context, state) =>
            state.whenOrNull(
              noContent: (message) => NoApprovedApplication(title: message),
              loaded: (carLoanOrder) =>
                  CreditApplicationContentWidget(carLoanOrder),
              loading: () => const CreditApplicationLoadingWidget(),
            ) ??
            const SizedBox(),
      ),
    );
  }
}
