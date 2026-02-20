part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<SearchCaseRoute>(path: SearchCaseRoute.path)
class SearchCaseRoute extends GoRouteData {
  const SearchCaseRoute();

  static const String path = '/search_case';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SearchCasePage();
}
