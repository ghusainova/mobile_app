import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../components/widgets/buttons/small_button.dart';
import '../../../../../shared/_data/models/auto_info.dart';
import '../../../domain/cars_to_review/cars_to_review_bloc.dart';

class SelectToViewWidget extends StatelessWidget {
  final AutoInfo autoInfo;

  const SelectToViewWidget(this.autoInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: BlocProvider.value(
        value: getIt.get<CarsToReviewBloc>(),
        child: BlocBuilder<CarsToReviewBloc, CarsToReviewState>(
          builder: (context, state) {
            final isInReview = state is HasCarsToReview &&
                state.autoInfoList.any((element) => element.id == autoInfo.id);

            if (isInReview) {
              return OutlinedBlueButton(
                text: 'Удалить из списка',
                slim: true,
                onPressed: () => _removeFromReview(context),
              );
            }

            return SmallButton(
              text: 'Выбрать для показа',
              onPressed: () => _addToReview(context),
            );
          },
        ),
      ),
    );
  }

  void _addToReview(BuildContext context) {
    context.read<CarsToReviewBloc>().add(AddToReview(autoInfo));
  }

  void _removeFromReview(BuildContext context) {
    context.read<CarsToReviewBloc>().add(RemoveFromReview(autoInfo.id));
  }
}
