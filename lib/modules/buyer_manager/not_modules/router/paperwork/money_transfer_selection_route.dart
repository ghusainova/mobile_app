part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<MoneyTransferSelectionRoute>(
  path: MoneyTransferSelectionRoute.path,
)
class MoneyTransferSelectionRoute extends GoRouteData {
  const MoneyTransferSelectionRoute();

  static const String path = '/money-transfer-selection';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MoneyTransferSelectionPage();
}
