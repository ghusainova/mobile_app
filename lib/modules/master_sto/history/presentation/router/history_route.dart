part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<HistoryRoute>(path: HistoryRoute.path)
class HistoryRoute extends GoRouteData {
  const HistoryRoute({this.isFinalStage = false});
  final bool isFinalStage;

  static const String path = '/history';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HistoryPage(isFinalStage: isFinalStage);
}
