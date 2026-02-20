part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarInfoRoute>(path: CarInfoRoute.path)
class CarInfoRoute extends GoRouteData {
  const CarInfoRoute();

  static const String path = '/car_info';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CarInfoPage();
}
