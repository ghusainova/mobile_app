part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<EditCarDataRoute>(path: EditCarDataRoute.path)
class EditCarDataRoute extends GoRouteData {
  const EditCarDataRoute();

  static const String path = '/edit-car-data-route';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EditCarDataPage();
}
