import 'package:flutter/material.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../components/widgets/page_form_widget.dart';
import '../../../../../components/widgets/table_content_item.dart';
import '../../../queue/domain/buyout/buyout_bloc.dart';

class CarDataConfirmationPage extends StatelessWidget {
  const CarDataConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final autoInfo = getIt.get<BuyoutBloc>().autoInfo;

    final dataList = {
      'Марка авто в объявлении': autoInfo?.auto?.brand ?? '',
      'Модель авто в объявлении': autoInfo?.auto?.model ?? '',
      'Год выпуска': autoInfo?.auto?.year.toString() ?? '',
    };

    return PageFormWidget(
      appBarTitle: 'Данные c объявления',
      pageTitle: 'Подойдите к авто и сверьте данные c объявления',
      children: [
        ...dataList.entries.map(
          (e) => TableContentItem(title: e.key, value: e.value),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              BlueButton(
                text: 'Данные верные',
                onPressed: () => _navigateToInspection(context),
              ),
              OutlinedBlueButton(
                margin: const EdgeInsets.only(top: 12),
                text: 'Изменить данные',
                showBorder: false,
                onPressed: () => const EditCarDataRoute().push(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _navigateToInspection(BuildContext context) {
    // final inArgs = interiorInspectionArgs.copyWith(
    //   onSubmit: () => const BuyerRoute().go(context),
    // );
    // final exArgs = exteriorInspectionArgs.copyWith(
    //   onSubmit: () => CarPhotoInspectionRoute(inArgs).push(context),
    // );

    // CarPhotoInspectionRoute(exArgs).push(context);
  }
}
