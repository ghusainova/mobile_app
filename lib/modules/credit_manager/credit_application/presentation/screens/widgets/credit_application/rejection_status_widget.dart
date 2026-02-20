import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../components/widgets/status_widget.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../shared/_data/enums/status_type_enum.dart';
import '../../../../../application_status/domain/bloc/credit_application_status_bloc.dart';

class RejectionStatusWidget extends StatelessWidget {
  const RejectionStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<CreditApplicationStatusBloc>(),
      child: BlocBuilder<CreditApplicationStatusBloc,
          CreditApplicationStatusState>(
        builder: (context, state) =>
            state.whenOrNull(
              noContent: (message) => StatusWidget(
                subtitle: message ?? 'Отказано',
                margin: const EdgeInsets.only(top: 8),
                status: StatusTypeEnum.error,
              ),
            ) ??
            const SizedBox(),
      ),
    );
  }
}
