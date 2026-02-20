part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<EditSellerDataRoute>(path: EditSellerDataRoute.path)
class EditSellerDataRoute extends GoRouteData {
  const EditSellerDataRoute();

  static const String path = '/edit_seller_data';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const EditSellerDataPage();
}
