import 'package:flutter/material.dart';

import '../../../../../components/widgets/snackbar/snackbar.dart';
import '../../../../../config/injectable/injectable.dart';
import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../shared/complete_client_session/data/models/complete_type_item.dart';
import '../../../../shared/complete_client_session/data/models/completing_reasons_args.dart';
import '../../../../shared/complete_client_session/domain/bloc/complete_client_session_bloc.dart';
import 'credit_completing_reasons_enum.dart';

enum CreditCompletingTypesEnum {
  redirectClient,
  stopWorkingWithClient,
  cancelCreditApplication,
}

extension CreditCompletingTypesEnumExt on CreditCompletingTypesEnum {
  String get title {
    switch (this) {
      case CreditCompletingTypesEnum.redirectClient:
        return 'Перенаправить клиента к другому менеджеру';
      case CreditCompletingTypesEnum.stopWorkingWithClient:
        return 'Приостановить работу с клиентом';
      case CreditCompletingTypesEnum.cancelCreditApplication:
        return 'Отменить заявку на Автокредит';
    }
  }

  String get subtitle {
    switch (this) {
      case CreditCompletingTypesEnum.redirectClient:
      case CreditCompletingTypesEnum.cancelCreditApplication:
        return '';
      case CreditCompletingTypesEnum.stopWorkingWithClient:
        return 'Заявка на Автокредит сохранится';
    }
  }

  VoidCallback? get routeNav {
    final context = rootNavigatorKey.currentContext;

    if (context == null) {
      return null;
    }

    switch (this) {
      case CreditCompletingTypesEnum.redirectClient:
        return () => _redirectClientRoute(context);
      case CreditCompletingTypesEnum.stopWorkingWithClient:
        return () => _stopWorkingWithClient(context);
      case CreditCompletingTypesEnum.cancelCreditApplication:
        return () => _cancelCreditApplication(context);
    }
  }
}

List<CompleteTypeItem> getCreditCompletingTypes() {
  return CreditCompletingTypesEnum.values
      .map(
        (e) => CompleteTypeItem(
          title: e.title,
          subtitle: e.subtitle,
          routeNav: e.routeNav,
        ),
      )
      .toList();
}

void _redirectClientRoute(BuildContext context) {
  ClientRedirectRoute(
    () => const CreditQueueRoute().go(context),
  ).push(context);
}

void _stopWorkingWithClient(BuildContext context) {
  getIt
      .get<CompleteClientSessionBloc>()
      .add(const CompleteClientSessionEvent.completeClientSession());
  const CreditQueueRoute().go(context);

  WidgetsBinding.instance.addPostFrameCallback(
    (_) => showSnackBar(context, 'Работа с клиентом приостановлена'),
  );
}

void _cancelCreditApplication(BuildContext context) {
  final args = CompletingReasonsRouteArgs(
    title: 'Почему вы хотите отменить заявку на Автокредит',
    reasonItems: getCreditCompletingReasons(),
    isCancel: true,
    onSubmit: () => const CreditQueueRoute().go(context),
  );
  CompletingReasonsRoute(args).push(context);
}
