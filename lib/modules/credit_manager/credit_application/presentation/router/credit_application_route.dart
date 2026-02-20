part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditApplicationRoute>(path: CreditApplicationRoute.path)
class CreditApplicationRoute extends GoRouteData {
  const CreditApplicationRoute();

  static const String path = '/credit_application';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreditApplicationPage();
}
