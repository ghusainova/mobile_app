part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<OwnerDataRoute>(path: OwnerDataRoute.path)
class OwnerDataRoute extends GoRouteData {
  const OwnerDataRoute();

  static const String path = '/owner_data';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OwnerDataPage();
}
