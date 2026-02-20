part of '../../../router/data/routes.dart';

final GlobalKey<NavigatorState> creditNavigatorKey =
    GlobalKey<NavigatorState>();
const creditBranches = <TypedStatefulShellBranch<StatefulShellBranchData>>[
  TypedStatefulShellBranch<CreditQueueBranch>(
    routes: [
      TypedGoRoute<CreditQueueRoute>(path: CreditQueueRoute.path),
    ],
  ),
  TypedStatefulShellBranch<ApplicationsInProgressBranch>(
    routes: [
      TypedGoRoute<ApplicationsInProgressRoute>(
        path: ApplicationsInProgressRoute.path,
      ),
    ],
  ),
];

@immutable
@TypedStatefulShellRoute<CreditManagerTabsRoute>(branches: creditBranches)
class CreditManagerTabsRoute extends StatefulShellRouteData {
  const CreditManagerTabsRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = creditNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      CreditManagerTabsPage(navigatorShell: navigationShell);
}

@immutable
class CreditQueueBranch extends StatefulShellBranchData {
  const CreditQueueBranch();
}

@immutable
class ApplicationsInProgressBranch extends StatefulShellBranchData {
  const ApplicationsInProgressBranch();
}
