import 'package:flutter/material.dart';

import '../../../../modules/sales_manager/client_processing/presentation/screens/widgets/action_button_widget.dart';
import '../../../modules/shared/queue/data/models/active_client_dto.dart';
import '../../widgets/card_widget/card_border_type_enum.dart';
import '../../widgets/card_widget/card_widget.dart';
import 'client_initials/client_initials_widget.dart';
import 'queue_info/queue_info_widget.dart';

class ClientProfileWidget extends StatelessWidget {
  final ActiveClientDTO activeClient;
  final bool showServiceTimer;
  final VoidCallback recallClient;

  const ClientProfileWidget({
    required this.activeClient,
    required this.recallClient,
    super.key,
    this.showServiceTimer = true,
  });

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyBottom,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ClientInitialsWidget(activeClient),
          QueueInfoWidget(activeClient, showServiceTimer: showServiceTimer),
          ActionButtonWidget(recallClient),
        ],
      ),
    );
  }
}
