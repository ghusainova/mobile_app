part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<ConfirmSellerDataRoute>(path: ConfirmSellerDataRoute.path)
class ConfirmSellerDataRoute extends GoRouteData {
  const ConfirmSellerDataRoute();

  static const String path = '/confirm_seller_data';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ConfirmSellerDataPage();
}
