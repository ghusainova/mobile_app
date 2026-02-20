part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<GetSellerDataRoute>(path: GetSellerDataRoute.path)
class GetSellerDataRoute extends GoRouteData {
  const GetSellerDataRoute();

  static const String path = '/get_seller_data';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const GetSellerDataPage();
}
