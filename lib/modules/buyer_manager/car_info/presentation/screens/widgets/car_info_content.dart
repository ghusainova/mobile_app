import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../../../components/widgets/table_content_item.dart';
import '../../../../../shared/_data/constants/global_constants.dart';
import '../../../domain/car_info/car_info_bloc.dart';

class CarInfoContent extends StatelessWidget {
  const CarInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: infoList(context),
    );
  }

  List<Widget> infoList(BuildContext context) {
    final auto = context.read<CarInfoBloc>().carInfo;

    return [
      TableContentItem(
        title: Constants.brand,
        value: auto?.brand,
      ),
      TableContentItem(
        title: Constants.model,
        value: auto?.model,
      ),
      TableContentItem(
        title: Constants.year,
        value: auto?.year.toString(),
      ),
      TableContentItem(
        title: Constants.stateNumber,
        value: auto?.stateNumber,
      ),
      TableContentItem(
        title: Constants.vin,
        value: auto?.vin,
        caseFormat: false,
      ),
      TableContentItem(
        title: Constants.bodyNumber,
        value: auto?.bodyNumber,
        caseFormat: false,
      ),
      TableContentItem(
        title: Constants.mileage,
        value: '${formatPriceText(auto?.mileage.toString())} км',
      ),
      TableContentItem(
        title: Constants.transmission,
        value: auto?.transmission,
      ),
      TableContentItem(
        title: Constants.drivetrain,
        value: auto?.drivetrain,
      ),
      TableContentItem(
        title: 'Отделка салона',
        value: auto?.interiorType,
      ),
      TableContentItem(
        title: 'Тип кондиционера',
        value: auto?.airConditioningType,
      ),
    ];
  }
}
