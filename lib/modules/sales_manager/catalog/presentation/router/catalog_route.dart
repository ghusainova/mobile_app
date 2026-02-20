part of '../../../../../components/router/data/routes.dart';

@immutable
class CatalogRoute extends GoRouteData {
  const CatalogRoute();

  static const String path = '/catalog';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CatalogPage();
}
