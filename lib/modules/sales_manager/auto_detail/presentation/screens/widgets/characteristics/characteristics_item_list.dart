import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/_data/constants/global_constants.dart';
import '../../../../../../shared/_domain/utility/formatters/price_input_formatter.dart';
import '../../../../domain/auto_detail/auto_detail_bloc.dart';
import '../hide_show_button.dart';
import '../../../../../../../components/widgets/table_content_item.dart';

class CharacteristicItemList extends StatefulWidget {
  const CharacteristicItemList({super.key});

  @override
  State<CharacteristicItemList> createState() => _CharacteristicItemListState();
}

class _CharacteristicItemListState extends State<CharacteristicItemList> {
  bool isShown = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children:
              isShown ? characteristics() : characteristics().sublist(0, 5),
        ),
        HideShowButton(
          toggleIsShown: (value) => setState(() => isShown = value),
        ),
      ],
    );
  }

  List<Widget> characteristics() {
    final autoInfo = context.read<AutoDetailBloc>().autoInfo;

    return [
      TableContentItem(
        title: Constants.year,
        value: autoInfo?.auto?.year.toString(),
      ),
      TableContentItem(
        title: Constants.mileage,
        value: '${formatPriceText(autoInfo?.auto?.mileage.toString())} км',
      ),
      TableContentItem(
        title: Constants.engineVolume,
        value: autoInfo?.auto?.engine,
      ),
      TableContentItem(
        title: Constants.engineType,
        value: autoInfo?.auto?.engineType,
      ),
      TableContentItem(
        title: Constants.transmission,
        value: autoInfo?.auto?.transmission,
      ),
      TableContentItem(
        title: 'Привод',
        value: autoInfo?.auto?.drivetrain,
      ),
      TableContentItem(
        title: 'Кузов',
        value: autoInfo?.auto?.bodyType,
      ),
      TableContentItem(
        title: 'Цвет кузова',
        value: autoInfo?.auto?.color,
      ),
      TableContentItem(
        title: 'Отделка салона',
        value: autoInfo?.auto?.interiorType,
      ),
      TableContentItem(
        title: 'Тип кондиционера',
        value: autoInfo?.auto?.airConditioningType,
      ),
      TableContentItem(
        title: 'Номер кузова',
        value: autoInfo?.auto?.bodyNumber,
        caseFormat: false,
      ),
      TableContentItem(
        title: 'VIN-код',
        value: autoInfo?.auto?.vin,
        caseFormat: false,
      ),
    ];
  }
}
