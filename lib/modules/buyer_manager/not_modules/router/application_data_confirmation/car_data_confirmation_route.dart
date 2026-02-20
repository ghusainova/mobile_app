part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarDataConfirmationRoute>(path: CarDataConfirmationRoute.path)
class CarDataConfirmationRoute extends GoRouteData {
  const CarDataConfirmationRoute();

  static const String path = '/car-data-confirmation';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CarDataConfirmationPage();
}
