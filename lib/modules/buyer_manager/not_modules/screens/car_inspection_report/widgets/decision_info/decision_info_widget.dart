import 'package:flutter/material.dart';

import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../../../components/widgets/status_widget.dart';
import '../../../../../queue/data/enum/buyer_status.dart';
import '../../../../../../shared/_data/enums/status_type_enum.dart';
import '../../../../../queue/domain/buyout/buyout_bloc.dart';
import 'buyout_offer_widget.dart';

class DecisionInfoWidget extends StatelessWidget {
  final bool hasDecision;

  const DecisionInfoWidget({super.key, this.hasDecision = false});

  @override
  Widget build(BuildContext context) {
    final status = getIt.get<BuyoutBloc>().status;
    bool checkInspectionReport =
        status?.buyerStatusEnum == BuyerStatusEnum.checkInspectionReport;

    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyBottom,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const BuyoutOfferWidget(),
          if (checkInspectionReport)
            const StatusWidget(
              margin: EdgeInsets.only(top: 16),
              status: StatusTypeEnum.info,
              subtitle: 'Решение по авто будет готово в течение 15 минут',
              infoCard: true,
            ),
          const StatusWidget(
            margin: EdgeInsets.only(top: 16),
            status: StatusTypeEnum.warning,
            title:
                'Kolesa.kz могут выкупить авто за 4 450 000 〒, если владелец поменяет данные в техпаспорте',
            subtitle: 'Реальный год авто не совпадает с данными в техпаспорте',
            infoCard: true,
          ),
          const StatusWidget(
            margin: EdgeInsets.only(top: 16),
            status: StatusTypeEnum.error,
            subtitle: 'Авто не подходит для выкупа по тех. состоянию',
            infoCard: true,
          ),
        ],
      ),
    );
  }
}
