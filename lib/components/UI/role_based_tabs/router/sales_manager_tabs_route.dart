part of '../../../router/data/routes.dart';

final GlobalKey<NavigatorState> salesNavigatorKey = GlobalKey<NavigatorState>();
const routeBranches = <TypedStatefulShellBranch<StatefulShellBranchData>>[
  TypedStatefulShellBranch<ClientBranch>(
    routes: [
      TypedGoRoute<ClientRoute>(path: ClientRoute.path),
    ],
  ),
  TypedStatefulShellBranch<CatalogBranch>(
    routes: [
      TypedGoRoute<CatalogRoute>(path: CatalogRoute.path),
    ],
  ),
];

@immutable
@TypedStatefulShellRoute<SalesManagerTabsRoute>(branches: routeBranches)
class SalesManagerTabsRoute extends StatefulShellRouteData {
  const SalesManagerTabsRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = salesNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      SalesManagerTabsPage(navigatorShell: navigationShell);
}

@immutable
class ClientBranch extends StatefulShellBranchData {
  const ClientBranch();
}

@immutable
class CatalogBranch extends StatefulShellBranchData {
  const CatalogBranch();
}
