part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarBodyRoute>(path: CarBodyRoute.path)
class CarBodyRoute extends GoRouteData {
  final AutoInfo? $extra;

  const CarBodyRoute(this.$extra);

  static const String path = '/car-body';

  @override
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CarBodyPage($extra);
}
