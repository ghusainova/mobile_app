part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarBodyDefectsRoute>(path: CarBodyDefectsRoute.path)
class CarBodyDefectsRoute extends GoRouteData {
  final CarBodyPart bodyPart;
  const CarBodyDefectsRoute(this.bodyPart);

  static const String path = '/car_body';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      bodyPart != CarBodyPart.defectConfirmation
          ? CarBodyDefectsPage(bodyPart: bodyPart)
          : const DefectsMapPage();
}
