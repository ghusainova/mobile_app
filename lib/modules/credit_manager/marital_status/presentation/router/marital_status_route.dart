part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<MaritalStatusRoute>(path: MaritalStatusRoute.path)
class MaritalStatusRoute extends GoRouteData {
  const MaritalStatusRoute();

  static const String path = '/marital_status';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MaritalStatusPage();
}
