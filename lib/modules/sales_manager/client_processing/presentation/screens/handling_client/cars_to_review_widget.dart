import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../catalog/domain/cars_to_review/cars_to_review_bloc.dart';
import '../../../../catalog/presentation/widgets/catalog_item_card_widget/catalog_item_card_widget.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/card_widget/card_widget.dart';

class CarsToReviewWidget extends StatelessWidget {
  const CarsToReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<CarsToReviewBloc>(),
      child: BlocBuilder<CarsToReviewBloc, CarsToReviewState>(
        builder: (context, state) =>
            state.whenOrNull(
              hasCarsToReview: (reviewList) => CardWidget(
                contentPadding: EdgeInsets.zero,
                title: 'Авто для показа',
                margin: const EdgeInsets.only(bottom: 16),
                titleChild: SizedBox(
                  width: 140,
                  child: OutlinedBlueButton(
                    text: 'Очистить список',
                    slim: true,
                    onPressed: () => _onClear(context),
                  ),
                ),
                child: Column(
                  children: reviewList
                      .map((e) => CatalogItemCard(autoInfo: e))
                      .toList(),
                ),
              ),
            ) ??
            const SizedBox(),
      ),
    );
  }

  void _onClear(BuildContext context) {
    context.read<CarsToReviewBloc>().add(const ClearReviewList());
  }
}
