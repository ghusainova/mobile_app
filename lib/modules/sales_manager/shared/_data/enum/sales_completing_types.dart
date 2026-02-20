import 'package:flutter/material.dart';

import '../../../../../components/router/app_router.dart';
import '../../../../../components/router/data/routes.dart';
import '../../../../shared/complete_client_session/data/models/complete_type_item.dart';
import '../../../../shared/complete_client_session/data/models/completing_reasons_args.dart';
import 'sales_completing_reasons.dart';

enum SalesCompletingTypesEnum {
  redirectClient,
  cancelClient,
}

extension SalesCompletingTypesEnumExt on SalesCompletingTypesEnum {
  String get title {
    switch (this) {
      case SalesCompletingTypesEnum.redirectClient:
        return 'Перенаправить клиента к другому менеджеру';
      case SalesCompletingTypesEnum.cancelClient:
        return 'Полностью завершить работу с клиентом';
    }
  }

  VoidCallback? get routeNav {
    final context = rootNavigatorKey.currentContext;

    if (context == null) {
      return null;
    }

    switch (this) {
      case SalesCompletingTypesEnum.redirectClient:
        return () => _redirectClient(context);
      case SalesCompletingTypesEnum.cancelClient:
        return () => _cancelClient(context);
    }
  }
}

List<CompleteTypeItem> getSalesCompletingTypes() {
  return SalesCompletingTypesEnum.values
      .map(
        (e) => CompleteTypeItem(
          title: e.title,
          routeNav: e.routeNav,
        ),
      )
      .toList();
}

void _redirectClient(BuildContext context) {
  ClientRedirectRoute(
    () => const ClientRoute().go(context),
  ).push(context);
}

void _cancelClient(BuildContext context) {
  final args = CompletingReasonsRouteArgs(
    reasonItems: getSalesCompletingReasons(),
    onSubmit: () => const ClientRoute().go(context),
  );
  CompletingReasonsRoute(args).push(context);
}
