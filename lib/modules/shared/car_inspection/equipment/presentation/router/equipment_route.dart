part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<EquipmentRoute>(path: EquipmentRoute.path)
class EquipmentRoute extends GoRouteData {
  final AutoInfo? $extra;

  const EquipmentRoute(this.$extra);

  static const String path = '/equipment';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EquipmentPage($extra);
  }
}
