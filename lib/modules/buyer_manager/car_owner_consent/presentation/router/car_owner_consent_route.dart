part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CarOwnerConsentRoute>(path: CarOwnerConsentRoute.path)
class CarOwnerConsentRoute extends GoRouteData {
  const CarOwnerConsentRoute();

  static const String path = '/car-owner-consent';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CarOwnerConsentPage();
}
