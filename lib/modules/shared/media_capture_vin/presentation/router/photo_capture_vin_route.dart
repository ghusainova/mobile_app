part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<PhotoCaptureVinRoute>(path: PhotoCaptureVinRoute.path)
class PhotoCaptureVinRoute extends GoRouteData {
  final MediaCaptureRouteArgs $extra;

  const PhotoCaptureVinRoute(this.$extra);

  static const String path = '/photo';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PhotoCaptureVinPage($extra);
}
