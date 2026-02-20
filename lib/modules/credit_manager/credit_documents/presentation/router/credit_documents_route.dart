part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<CreditDocumentsRoute>(path: CreditDocumentsRoute.path)
class CreditDocumentsRoute extends GoRouteData {
  const CreditDocumentsRoute();

  static const String path = '/credit_documents';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreditDocumentsPage();
}
