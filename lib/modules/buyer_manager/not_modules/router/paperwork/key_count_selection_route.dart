part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<KeyCountSelectionRoute>(path: KeyCountSelectionRoute.path)
class KeyCountSelectionRoute extends GoRouteData {
  const KeyCountSelectionRoute();

  static const String path = '/key-count-selection';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KeyCountSelectionPage();
}
