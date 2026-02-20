import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../components/widgets/buttons/blue_button.dart';
import '../../../../../../../components/widgets/buttons/outlined_blue_button.dart';
import '../../../../../../../components/widgets/dialog_widget.dart';
import '../../../../../../../config/injectable/injectable.dart';
import '../../../../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';
import '../../../../data/models/phase.dart';
import '../../../../domain/history/history_bloc.dart';

class HistoryNavBtns extends StatelessWidget {
  const HistoryNavBtns({required this.onTap, super.key});
  final void Function(Phase? phase) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Column(
        children: [
          BlueButton(
            onPressed: () => _continueWork(context),
          ),
          OutlinedBlueButton(
            onPressed: () => _cancelCase(context),
            text: 'Отменить осмотр',
            showBorder: false,
          ),
        ],
      ),
    );
  }

  void _continueWork(BuildContext context) {
    if (!context.mounted) return;

    final historyList = context.read<HistoryBloc>().history?.historyList ?? [];
    final lastVisitedPhase =
        historyList.lastWhere((Phase phase) => phase.availabilityStatus);

    onTap(lastVisitedPhase);
  }

  void _cancelCase(BuildContext context) {
    if (!context.mounted) return;

    final scanCase = getIt.get<ScanCasesBloc>().scanCase;

    showDialog(
      context: context,
      builder: (_) => DialogWidget(
        alertTitle:
            'Вы уверены, что хотите отменить осмотр ${scanCase!.brand} ${scanCase.model}?',
        alertSubTitle: 'Восстановить данные будет невозможно',
        submitBtnTitle: 'Да, отменить',
        onSubmit: () => _cancelEvent(context),
        onDecline: () => context.pop(),
      ),
    );
  }

  void _cancelEvent(BuildContext context) {
    context.pop();
    getIt.get<HistoryBloc>().add(const HistoryEvent.cancelCase());
  }
}
