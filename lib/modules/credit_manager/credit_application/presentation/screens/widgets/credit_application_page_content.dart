import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/UI/client_info_widgets/client_profile_widget.dart';
import '../../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../application_status/presentation/widgets/next_steps_widget.dart';
import '../../../../shared/_data/enum/credit_completing_types_enum.dart';
import 'credit_application/credit_application_widget.dart';

class CreditApplicationPageContent extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const CreditApplicationPageContent(this.onRefresh, {super.key});

  @override
  Widget build(BuildContext context) {
    final activeClient = getIt.get<QueueBloc>().activeClient;

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          if (activeClient != null)
            ClientProfileWidget(
              activeClient: activeClient,
              showServiceTimer: false,
              recallClient: () => recallClient(context),
            ),
          const CreditApplicationWidget(),
          const NextStepsWidget(),
          CardWidget(
            child: OutlinedBlueButton(
              text: 'Завершить работу',
              onPressed: () => _onComplete(context),
            ),
          ),
        ],
      ),
    );
  }

  void recallClient(BuildContext context) {
    final clientTransactionId =
        getIt.get<QueueBloc>().activeClient?.clientTransactionId;

    if (clientTransactionId != null) {
      context.read<QueueBloc>().add(const RecallClient());
    }
  }

  void _onComplete(BuildContext context) {
    CompletingTypeSelectionRoute(getCreditCompletingTypes()).push(context);
  }
}
