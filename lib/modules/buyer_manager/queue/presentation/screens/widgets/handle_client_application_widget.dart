import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/UI/client_info_widgets/client_profile_widget.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../shared/queue/data/models/active_client_dto.dart';
import '../../../../../shared/queue/domain/bloc/queue_bloc.dart';
import 'application_not_found_widget.dart';
import 'purchase_application_card_widget.dart';
import '../../../data/models/client_case_request_params.dart';
import '../../../domain/buyout/buyout_bloc.dart';

class HandleClientApplicationWidget extends StatefulWidget {
  final ActiveClientDTO activeClient;

  const HandleClientApplicationWidget(this.activeClient, {super.key});

  @override
  State<HandleClientApplicationWidget> createState() =>
      _HandleClientApplicationWidgetState();
}

class _HandleClientApplicationWidgetState
    extends State<HandleClientApplicationWidget> {
  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClientProfileWidget(
          activeClient: widget.activeClient,
          recallClient: () => recallClient(context),
        ),
        BlocProvider.value(
          value: getIt.get<BuyoutBloc>(),
          child: Expanded(
            child: CardWidget(
              contentPadding: EdgeInsets.zero,
              child: BlocBuilder<BuyoutBloc, BuyoutState>(
                builder: (context, state) =>
                    state.whenOrNull(
                      loading: () => Container(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 5,
                        ),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                      hasOrder: (order) => PurchaseApplicationCardWidget(order),
                      noOrder: () => const ApplicationNotFoundWidget(),
                    ) ??
                    const SizedBox(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initBloc() {
    final requestBody = ClientCaseRequestParams(
      sellerPhone: widget.activeClient.phone,
      clientIin: widget.activeClient.iin,
    );

    getIt.get<BuyoutBloc>().add(GetBuyerCatalog(requestBody: requestBody));
  }

  void recallClient(BuildContext context) {
    context.read<QueueBloc>().add(const RecallClient());
    context.pop();
  }
}
