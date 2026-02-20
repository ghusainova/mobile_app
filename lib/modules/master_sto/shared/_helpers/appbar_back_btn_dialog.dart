import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/injectable/injectable.dart';
import '../../../../components/router/data/routes.dart';
import '../../../../components/widgets/dialog_widget.dart';
import '../../scan_cases/domain/scan_cases/scan_cases_bloc.dart';

void onCloseBtnDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => DialogWidget(
      alertTitle: 'Вы уверены, что хотите закрыть осмотр?',
      alertSubTitle:
          'Осмотр можно продолжить открыв заявку в списке на главной странце',
      submitBtnTitle: 'Закрыть',
      onSubmit: () => _onMasterPageRoute(context),
      onDecline: () => context.pop(),
    ),
  );
}

void _onMasterPageRoute(BuildContext context) {
  getIt.get<ScanCasesBloc>().add(const Load());
  const MasterStoRoute().go(context);
}
