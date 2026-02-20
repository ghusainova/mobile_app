part of '../../../../../components/router/data/routes.dart';

@immutable
class ApplicationsInProgressRoute extends GoRouteData {
  const ApplicationsInProgressRoute();

  static const String path = '/applications_in_progress';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ApplicationsInProgressPage();
}
