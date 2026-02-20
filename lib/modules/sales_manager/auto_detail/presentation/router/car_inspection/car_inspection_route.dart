part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarInspectionRoute>(path: CarInspectionRoute.path)
class CarInspectionRoute extends GoRouteData {
  final AutoInfo? $extra;

  const CarInspectionRoute(this.$extra);

  static const String path = '/car-inspection';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CarInspectionPage(autoInfo: $extra);
  }
}
