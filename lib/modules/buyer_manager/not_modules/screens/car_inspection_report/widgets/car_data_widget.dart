import 'package:flutter/material.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/router/data/routes.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/car_inspection_list_item.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../../../shared/car_inspection/shared/presentation/car_inspection_list.dart';
import '../../../../queue/domain/buyout/buyout_bloc.dart';

class CarDataWidget extends StatelessWidget {
  const CarDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final autoInfo = getIt.get<BuyoutBloc>().autoInfo;
    return CardWidget(
      title: 'Данные авто',
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          CarInspectionItem(
            icon: AppAssets.carReportIcon,
            title: 'Информация об авто',
            onPressed: () => const CarInfoRoute().push(context),
          ),
          CarInspectionList(autoInfo),
        ],
      ),
    );
  }
}
