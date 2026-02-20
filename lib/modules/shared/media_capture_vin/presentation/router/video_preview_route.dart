part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<VideoPreviewRoute>(path: VideoPreviewRoute.path)
class VideoPreviewRoute extends GoRouteData {
  final String $extra;

  const VideoPreviewRoute(this.$extra);

  static const String path = '/video-preview';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      VideoPreviewPage($extra);
}
