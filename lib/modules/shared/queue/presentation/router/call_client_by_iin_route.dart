part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CallClientByIinRoute>(path: CallClientByIinRoute.path)
class CallClientByIinRoute extends GoRouteData {
  const CallClientByIinRoute();

  static const String path = '/call-client-by-iin';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CallClientByIinPage();
}
