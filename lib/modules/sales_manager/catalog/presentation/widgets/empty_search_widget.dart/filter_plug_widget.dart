import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/filter.dart';
import '../../../../../../components/styles/app_assets.dart';
import '../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../components/widgets/card_widget/card_border_type_enum.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';
import '../../../domain/filter_bloc/filter_bloc.dart';

class FilterPlugWidget extends StatelessWidget {
  const FilterPlugWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final filterBloc = context.read<FilterBloc>();

    return CardWidget(
      borderRadius: CardBorderTypeEnum.onlyBottom,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.emptySearchImage,
            width: 140,
            height: 94,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              'Ничего не найдено',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          Text(
            'Сбросьте фильтры или посмотрите рекомендованные варианты ниже',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: BlueButton(
              onPressed: () => filterBloc.add(const ClearFilter()),
              text: identical(filterBloc.currentFilter, const Filter())
                  ? 'Обновить'
                  : 'Сбросить фильтры',
            ),
          ),
        ],
      ),
    );
  }
}
