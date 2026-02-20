part of '../../../router/data/routes.dart';

@immutable
@TypedGoRoute<StatusPageRoute>(path: StatusPageRoute.path)
class StatusPageRoute extends GoRouteData {
  final StatusPageConfigs $extra;
  const StatusPageRoute(this.$extra);

  static const String path = '/status_route';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      StatusPage(configs: $extra);
}
