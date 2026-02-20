part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<OtherPartsRoute>(path: OtherPartsRoute.path)
class OtherPartsRoute extends GoRouteData {
  final AutoInfo? $extra;

  const OtherPartsRoute(this.$extra);

  static const String path = '/other-parts';

  @override
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OtherPartsPage($extra);
}
