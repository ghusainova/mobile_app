part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<LoginRoute>(path: LoginRoute.path)
class LoginRoute extends GoRouteData {
  const LoginRoute();

  static const String path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginPage();
}
