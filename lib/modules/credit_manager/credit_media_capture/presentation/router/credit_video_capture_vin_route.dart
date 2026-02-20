part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditVideoCaptureVinRoute>(path: CreditVideoCaptureVinRoute.path)
class CreditVideoCaptureVinRoute extends GoRouteData {
  final CreditMediaCaptureRouteArgs $extra;

  const CreditVideoCaptureVinRoute(this.$extra);

  static const String path = '/credit-video';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CreditVideoCaptureVinPage($extra);
}
