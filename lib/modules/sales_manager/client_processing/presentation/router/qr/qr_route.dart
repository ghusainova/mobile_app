part of '../../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<QrRoute>(path: QrRoute.path)
class QrRoute extends GoRouteData {
  final AutoInfo $extra;

  const QrRoute(this.$extra);

  static const String path = '/qr';

  @override
  Widget build(BuildContext context, GoRouterState state) => QrPage($extra);
}
