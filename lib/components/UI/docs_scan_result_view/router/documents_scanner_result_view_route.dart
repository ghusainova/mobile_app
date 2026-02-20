part of '../../../router/data/routes.dart';

@immutable
@TypedGoRoute<DocumentsScannerResultViewRoute>(
  path: DocumentsScannerResultViewRoute.path,
)
class DocumentsScannerResultViewRoute extends GoRouteData {
  final List<String> $extra;

  const DocumentsScannerResultViewRoute(this.$extra);

  static const String path = '/documents-scanner-result-view';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      DocsScanResultViewPage($extra);
}
