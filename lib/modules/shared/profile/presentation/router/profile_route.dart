part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<ProfileRoute>(path: ProfileRoute.path)
class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  static const String path = '/profile';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();
}
