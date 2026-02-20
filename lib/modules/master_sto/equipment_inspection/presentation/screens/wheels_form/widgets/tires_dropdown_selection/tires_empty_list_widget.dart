import 'package:flutter/material.dart';

import '../../../../../../../../config/injectable/injectable.dart';
import '../../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../domain/tires/tires_bloc.dart';

class TireEmptyListWidget extends StatelessWidget {
  const TireEmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Не удалось загрузить список шин',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          BlueButton(
            text: 'Обновить',
            onPressed: () => getIt.get<TiresBloc>().add(const GetTiresBrands()),
          ),
        ],
      ),
    );
  }
}
