import 'package:flutter/material.dart';

import '../../../../../../config/injectable/injectable.dart';
import '../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';

class HistoryTitleWidget extends StatelessWidget {
  final bool isFinalStage;

  const HistoryTitleWidget({required this.isFinalStage, super.key});

  @override
  Widget build(BuildContext context) {
    final scanCase = getIt.get<ScanCasesBloc>().scanCase;

    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '${isFinalStage ? 'Подтвердите результаты осмотра' : 'Продолжите осмотр'} ${scanCase?.brand} ${scanCase?.model}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              textAlign: TextAlign.start,
              'Госномер ${scanCase?.stateNumber}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
