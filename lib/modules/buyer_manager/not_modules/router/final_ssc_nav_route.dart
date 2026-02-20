part of '../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<FinalSscNavRoute>(path: FinalSscNavRoute.path)
class FinalSscNavRoute extends GoRouteData {
  const FinalSscNavRoute();

  static const String path = '/final-ssc-nav';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FinalSscNavPage();
}
