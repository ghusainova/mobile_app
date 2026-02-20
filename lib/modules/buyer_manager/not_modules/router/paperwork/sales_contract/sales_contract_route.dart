part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<SalesContractRoute>(path: SalesContractRoute.path)
class SalesContractRoute extends GoRouteData {
  final SalesContractRouteArgs $extra;

  const SalesContractRoute(this.$extra);

  static const String path = '/sales-contract';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SalesContractPage($extra);
}

class SalesContractRouteArgs {
  final String title;
  final String subtitle;
  //TODO: pass PDF file
  final void Function() onSubmit;

  const SalesContractRouteArgs({
    required this.title,
    required this.subtitle,
    required this.onSubmit,
  });
}
