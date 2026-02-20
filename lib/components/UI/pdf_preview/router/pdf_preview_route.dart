part of '../../../router/data/routes.dart';

@immutable
@TypedGoRoute<PdfPreviewRoute>(path: PdfPreviewRoute.path)
class PdfPreviewRoute extends GoRouteData {
  final String $extra;

  const PdfPreviewRoute(this.$extra);

  static const String path = '/pdf_preview';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PdfPreviewPage($extra);
}
