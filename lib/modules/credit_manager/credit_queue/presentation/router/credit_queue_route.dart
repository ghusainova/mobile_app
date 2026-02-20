part of '../../../../../components/router/data/routes.dart';

@immutable
class CreditQueueRoute extends GoRouteData {
  const CreditQueueRoute();

  static const String path = '/credit_queue';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreditQueuePage();
}
