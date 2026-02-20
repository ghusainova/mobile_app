part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<DataForDocPrintingRoute>(path: DataForDocPrintingRoute.path)
class DataForDocPrintingRoute extends GoRouteData {
  const DataForDocPrintingRoute();

  static const String path = '/data-for-doc-printing';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DataForDocPrintingPage();
}
