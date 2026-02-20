part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<MasterStoRoute>(path: MasterStoRoute.path)
class MasterStoRoute extends GoRouteData {
  const MasterStoRoute();

  static const String path = '/master-sto';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MasterStoPage();
}
