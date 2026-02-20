part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditAdditionalInfoRoute>(
  path: CreditAdditionalInfoRoute.path,
)
class CreditAdditionalInfoRoute extends GoRouteData {
  const CreditAdditionalInfoRoute();

  static const String path = '/credit_additional_info';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreditAdditionalInfoPage();
}
