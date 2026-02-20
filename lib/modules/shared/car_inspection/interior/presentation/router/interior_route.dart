part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<InteriorRoute>(path: InteriorRoute.path)
class InteriorRoute extends GoRouteData {
  final AutoInfo? $extra;

  const InteriorRoute(this.$extra);

  static const String path = '/interior';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InteriorPage($extra);
}
