import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../components/widgets/no_content_widget.dart';
import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../domain/bloc/credit_application_status_bloc.dart';
import 'next_steps_content.dart';

class NextStepsWidget extends StatelessWidget {
  const NextStepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<CreditApplicationStatusBloc>(),
      child: BlocConsumer<CreditApplicationStatusBloc,
          CreditApplicationStatusState>(
        listener: (context, state) => state.whenOrNull(
          error: (message) => showSnackBar(context, message),
        ),
        builder: (context, state) =>
            state.whenOrNull(
              loaded: (statusList) => NextStepsContent(statusList),
              error: (message) => NoContentWidget(
                errorMessage: 'Ошибка загрузки',
                fixedHeight: true,
                onRefresh: load,
              ),
            ) ??
            const SizedBox(),
      ),
    );
  }

  void load() {
    getIt.get<CreditApplicationStatusBloc>().add(const GetStatusList());
  }
}
