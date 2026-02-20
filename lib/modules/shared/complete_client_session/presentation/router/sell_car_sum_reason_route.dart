part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<SellCarSumReasonRoute>(path: SellCarSumReasonRoute.path)
class SellCarSumReasonRoute extends GoRouteData {
  const SellCarSumReasonRoute();

  static const String path = '/sell-car-sum-reason';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SellCarSumReasonPage();
}
