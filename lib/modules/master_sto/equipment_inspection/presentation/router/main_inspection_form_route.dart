part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<MainInspectionFormRoute>(path: MainInspectionFormRoute.path)
class MainInspectionFormRoute extends GoRouteData {
  final InspectionItemEnum $extra;

  const MainInspectionFormRoute(this.$extra);

  static const String path = '/main-inspection-form';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MainInspectionFormPage($extra);
}
