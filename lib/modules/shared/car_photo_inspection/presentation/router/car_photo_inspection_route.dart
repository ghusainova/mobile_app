part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarPhotoInspectionRoute>(path: CarPhotoInspectionRoute.path)
class CarPhotoInspectionRoute extends GoRouteData {
  final CarPhotoInspectionArgs $extra;

  const CarPhotoInspectionRoute(this.$extra);

  static const String path = '/car-photo-inspection';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CarPhotoInspectionPage($extra);
}
