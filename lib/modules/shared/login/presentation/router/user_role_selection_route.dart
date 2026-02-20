part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<UserRoleSelectionRoute>(path: UserRoleSelectionRoute.path)
class UserRoleSelectionRoute extends GoRouteData {
  const UserRoleSelectionRoute();

  static const String path = '/user-role-selection';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const UserRoleSelectionPage();
}
