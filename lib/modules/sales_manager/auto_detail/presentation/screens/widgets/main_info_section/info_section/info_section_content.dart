import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../components/widgets/main_info_title.dart';
import '../../../../../../../../components/widgets/parking_info.dart';
import '../../../../../../../shared/queue/domain/bloc/queue_bloc.dart';
import '../../../../../../catalog/presentation/widgets/catalog_item_card_widget/item_card_price_widget.dart';
import '../../../../../../catalog/presentation/widgets/catalog_item_card_widget/item_select_to_view_widget.dart';
import '../../../../../domain/auto_detail/auto_detail_bloc.dart';
import 'car_inspection_button.dart';

class InfoSectionContent extends StatelessWidget {
  const InfoSectionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final autoInfo = context.read<AutoDetailBloc>().autoInfo;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainInfoTitleWidget(
                autoInfo: autoInfo,
                textSize: 16,
              ),
              ParkingInfoWidget(autoInfo?.parking, textSize: 14),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ItemCardPriceWidget(autoInfo),
          ),
          if (autoInfo != null &&
              context.read<QueueBloc>().activeClient != null)
            SelectToViewWidget(autoInfo),
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: CarInspectionButton(),
          ),
        ],
      ),
    );
  }
}
