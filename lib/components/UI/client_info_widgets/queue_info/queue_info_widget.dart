import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../modules/sales_manager/client_processing/data/models/info_widget_item.dart';
import '../../../../modules/shared/_domain/bloc/timers/forward_timer/forward_timer_bloc.dart';
import '../../../../modules/shared/_domain/utility/check_role.dart';
import '../../../../modules/shared/_domain/utility/ticker.dart';
import '../../../../modules/shared/login/data/enum/user_role_enum.dart';
import '../../../../modules/shared/queue/data/models/active_client_dto.dart';
import '../../../../modules/shared/queue/domain/bloc/queue_bloc.dart';
import '../../../styles/app_colors.dart';
import '../../../../modules/shared/_domain/utility/formatters/time_from_seconds_formatter.dart';
import '../client_info_items_widget.dart';

class QueueInfoWidget extends StatefulWidget {
  final ActiveClientDTO activeClient;
  final bool showServiceTimer;

  const QueueInfoWidget(
    this.activeClient, {
    super.key,
    this.showServiceTimer = true,
  });

  @override
  State<QueueInfoWidget> createState() => _QueueInfoWidgetState();
}

class _QueueInfoWidgetState extends State<QueueInfoWidget> {
  late final ForwardTimerBloc forwardTimerBloc;
  int? tableNumber;

  @override
  void initState() {
    super.initState();
    initBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClientInfoItemWidget(
                InfoWidgetItem(
                  title: 'Талон',
                  subtitle: '№${widget.activeClient.ticketNumber}',
                ),
              ),
              ClientInfoItemWidget(
                InfoWidgetItem(
                  title: 'Ожидание',
                  subtitle: formatTimeFromSeconds(
                    widget.activeClient.waitTimeSeconds ?? 0,
                  ),
                ),
              ),
              if (widget.showServiceTimer)
                BlocProvider.value(
                  value: forwardTimerBloc,
                  child: BlocBuilder<ForwardTimerBloc, ForwardTimerState>(
                    builder: (context, state) {
                      return ClientInfoItemWidget(
                        InfoWidgetItem(
                          title: 'Обслуживание',
                          subtitle: formatTimeFromSeconds(
                            (state as InProgress).duration ?? 0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        if (tableNumber != null && !isManager(UserRoleEnum.creditManager))
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Стол №$tableNumber',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.inactiveText),
            ),
          ),
      ],
    );
  }

  void initBloc() {
    if (widget.showServiceTimer) {
      forwardTimerBloc = ForwardTimerBloc(
        ticker: const Ticker(),
        initialDuration: widget.activeClient.serviceTimeSeconds ?? 0,
      );

      if (widget.activeClient.serviceTimeSeconds != null) {
        forwardTimerBloc.add(Start(widget.activeClient.serviceTimeSeconds!));
      }
    }

    tableNumber = context.read<QueueBloc>().branchUser?.tableNumber;
  }
}
