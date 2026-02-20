part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<AdditionalInfoRoute>(path: AdditionalInfoRoute.path)
class AdditionalInfoRoute extends GoRouteData {
  const AdditionalInfoRoute();

  static const String path = '/additional_info';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AdditionalInfoPage();
}
