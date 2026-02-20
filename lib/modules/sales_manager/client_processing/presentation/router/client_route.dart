part of '../../../../../components/router/data/routes.dart';

@immutable
class ClientRoute extends GoRouteData {
  const ClientRoute();

  static const String path = '/client';

  @override
  Widget build(BuildContext context, GoRouterState state) => const ClientPage();
}
