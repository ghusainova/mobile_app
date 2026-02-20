part of '../../../../../components/router/data/routes.dart';

final GlobalKey<NavigatorState> buyerNavigatorKey = GlobalKey<NavigatorState>();
const buyerBranches = <TypedStatefulShellBranch<StatefulShellBranchData>>[
  TypedStatefulShellBranch<BuyerQueueBranch>(
    routes: [
      TypedGoRoute<BuyerQueueRoute>(path: BuyerQueueRoute.path),
    ],
  ),
  TypedStatefulShellBranch<CarsToTransferBranch>(
    routes: [
      TypedGoRoute<CarsToTransferRoute>(
        path: CarsToTransferRoute.path,
      ),
    ],
  ),
];

@immutable
@TypedStatefulShellRoute<BuyerManagerTabsRoute>(branches: buyerBranches)
class BuyerManagerTabsRoute extends StatefulShellRouteData {
  const BuyerManagerTabsRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = buyerNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      BuyerManagerTabsPage(navigatorShell: navigationShell);
}

@immutable
class BuyerQueueBranch extends StatefulShellBranchData {
  const BuyerQueueBranch();
}

@immutable
class CarsToTransferBranch extends StatefulShellBranchData {
  const CarsToTransferBranch();
}
