part of '../../../../../components/router/data/routes.dart';

@immutable
class CarsToTransferRoute extends GoRouteData {
  const CarsToTransferRoute();

  static const String path = '/cars-to-transfer';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CarsToTransferPage();
}
