part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CompletingReasonsRoute>(path: CompletingReasonsRoute.path)
class CompletingReasonsRoute extends GoRouteData {
  final CompletingReasonsRouteArgs $extra;

  const CompletingReasonsRoute(this.$extra);

  static const String path = '/completing-reasons';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CompletingReasonsPage($extra);
}
