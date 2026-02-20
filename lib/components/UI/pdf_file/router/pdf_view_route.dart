part of '../../../router/data/routes.dart';

@immutable
@TypedGoRoute<PdfViewRoute>(path: PdfViewRoute.path)
class PdfViewRoute extends GoRouteData {
  final String $extra;

  const PdfViewRoute(this.$extra);

  static const String path = '/pdf-view';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PdfViewPage($extra);
}
