part of '../../../../../components/router/data/routes.dart';

@immutable
class BuyerQueueRoute extends GoRouteData {
  const BuyerQueueRoute();

  static const String path = '/buyer_queue';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BuyerQueuePage();
}
