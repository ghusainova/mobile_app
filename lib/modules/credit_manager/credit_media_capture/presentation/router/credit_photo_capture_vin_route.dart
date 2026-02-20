part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditPhotoCaptureVinRoute>(path: CreditPhotoCaptureVinRoute.path)
class CreditPhotoCaptureVinRoute extends GoRouteData {
  final CreditMediaCaptureRouteArgs $extra;

  const CreditPhotoCaptureVinRoute(this.$extra);

  static const String path = '/credit-photo';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CreditPhotoCaptureVinPage($extra);
}
