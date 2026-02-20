part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<OwnerAddressSubmitRoute>(path: OwnerAddressSubmitRoute.path)
class OwnerAddressSubmitRoute extends GoRouteData {
  const OwnerAddressSubmitRoute();

  static const String path = '/owner-address-submit';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OwnerAddressSubmitPage();
}
