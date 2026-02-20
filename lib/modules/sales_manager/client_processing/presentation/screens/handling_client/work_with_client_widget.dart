import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/complete_client_session/presentation/screens/widgets/complete_client_session_widget.dart';
import '../../../../../shared/queue/data/models/active_client_dto.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/UI/client_info_widgets/client_profile_widget.dart';
import '../../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../shared/_data/enum/sales_completing_types.dart';
import 'approved_credit_widgets/approved_credit_widget.dart';

import 'cars_to_review_widget.dart';
import 'recommended_autos_widget.dart';

class WorkWithClientWidget extends StatelessWidget {
  final ActiveClientDTO activeClient;

  const WorkWithClientWidget(this.activeClient, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListView(
              children: [
                ClientProfileWidget(
                  activeClient: activeClient,
                  recallClient: () => _recallClient(context),
                ),
                Column(
                  children: [
                    ApprovedCreditWidget(activeClient.iin),
                    const CarsToReviewWidget(),
                    const RecommendedAutosWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
        CompleteClientSessionWidget(
          onTap: () => _completeClientSession(context),
        ),
      ],
    );
  }

  void _recallClient(BuildContext context) {
    final clientTransactionId = activeClient.clientTransactionId;

    if (clientTransactionId != null) {
      context.read<QueueBloc>().add(const RecallClient());
    }
  }

  void _completeClientSession(BuildContext context) {
    final salesCompletingTypes = getSalesCompletingTypes();
    CompletingTypeSelectionRoute(salesCompletingTypes).push(context);
  }

  Future<void> _onRefresh(BuildContext context) async {
    context.read<QueueBloc>().add(const GetManagerState(refresh: true));
  }
}
