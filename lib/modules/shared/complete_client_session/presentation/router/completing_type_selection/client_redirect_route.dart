part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<ClientRedirectRoute>(path: ClientRedirectRoute.path)
class ClientRedirectRoute extends GoRouteData {
  final VoidCallback $extra;
  const ClientRedirectRoute(this.$extra);

  static const String path = '/client-redirect';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ClientRedirectPage($extra);
}
