part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CompletingTypeSelectionRoute>(
  path: CompletingTypeSelectionRoute.path,
)
class CompletingTypeSelectionRoute extends GoRouteData {
  final List<CompleteTypeItem> $extra;

  const CompletingTypeSelectionRoute(this.$extra);

  static const String path = '/completing-type-selection';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CompletingTypeSelectionPage($extra);
}
