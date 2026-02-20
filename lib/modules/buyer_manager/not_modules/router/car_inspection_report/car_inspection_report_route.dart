part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarInspectionReportRoute>(path: CarInspectionReportRoute.path)
class CarInspectionReportRoute extends GoRouteData {
  const CarInspectionReportRoute();

  static const String path = '/car-inspection-report';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CarInspectionReportPage();
}
