part of '../../../../../components/router/data/routes.dart';

@immutable
@TypedGoRoute<AutoDetailRoute>(path: AutoDetailRoute.path)
class AutoDetailRoute extends GoRouteData {
  final AutoDetailRouteArgs $extra;

  const AutoDetailRoute(this.$extra);

  static const String path = '/auto';

  @override
  Widget build(BuildContext context, GoRouterState state) => AutoDetailPage(
        autoInfo: $extra.autoInfo,
        fromApprovedCredit: $extra.fromApprovedCredit,
      );
}

@JsonSerializable()
class AutoDetailRouteArgs {
  final AutoInfo autoInfo;
  final bool fromApprovedCredit;

  const AutoDetailRouteArgs({
    required this.autoInfo,
    this.fromApprovedCredit = false,
  });

  factory AutoDetailRouteArgs.fromJson(Map<String, dynamic> json) =>
      _$AutoDetailRouteArgsFromJson(json);

  Map<String, dynamic> toJson() => _$AutoDetailRouteArgsToJson(this);
}
