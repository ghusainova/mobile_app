part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<WheelsInspectionFormRoute>(path: WheelsInspectionFormRoute.path)
class WheelsInspectionFormRoute extends GoRouteData {
  final InspectionItemEnum $extra;

  const WheelsInspectionFormRoute(this.$extra);

  static const String path = '/wheels-inspection-form';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WheelsInspectionFormPage($extra);
}
