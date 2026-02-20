part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<VideoCaptureVinRoute>(path: VideoCaptureVinRoute.path)
class VideoCaptureVinRoute extends GoRouteData {
  final MediaCaptureRouteArgs $extra;

  const VideoCaptureVinRoute(this.$extra);

  static const String path = '/video';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VideoCaptureVinPage($extra);
}
