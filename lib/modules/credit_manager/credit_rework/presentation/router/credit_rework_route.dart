part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditReworkRoute>(path: CreditReworkRoute.path)
class CreditReworkRoute extends GoRouteData {
  const CreditReworkRoute();

  static const String path = '/credit_rework';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreditReworkPage();
}
