import 'package:flutter/material.dart';

import '../../../../../../../../config/injectable/injectable.dart';
import '../../../../../../history/domain/history/history_bloc.dart';

class DefectSubtitle extends StatelessWidget {
  const DefectSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    final paintThickness = getIt.get<HistoryBloc>().paintThickness;

    if (paintThickness?.microMeterMax != null &&
        paintThickness?.microMeterMax != '') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Укажите точки с толщиной краски \n',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (paintThickness?.microMeterMax != null)
                TextSpan(
                  text: 'больше ${paintThickness?.microMeterMax} мкм',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              TextSpan(
                text: ' и найденные дефекты',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        'Укажите найденные дефекты',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
