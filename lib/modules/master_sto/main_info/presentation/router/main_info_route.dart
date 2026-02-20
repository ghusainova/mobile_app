part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<MainInfoRoute>(path: MainInfoRoute.path)
class MainInfoRoute extends GoRouteData {
  const MainInfoRoute();

  static const String path = '/main_info';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MainInfoPage();
}
