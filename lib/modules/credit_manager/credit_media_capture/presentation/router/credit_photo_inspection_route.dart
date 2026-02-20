part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditPhotoInspectionRoute>(path: CreditPhotoInspectionRoute.path)
class CreditPhotoInspectionRoute extends GoRouteData {
  final CreditPhotoInspectionArgs $extra;

  const CreditPhotoInspectionRoute(this.$extra);

  static const String path = '/credit-photo-inspection';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      CreditPhotoInspectionPage($extra);
}
