part of '../../../../../presentation/router/data/routes.dart';

@immutable
@TypedGoRoute<{{filename.pascalCase()}}Route>(path: {{filename.pascalCase()}}Route.path)
class {{filename.pascalCase()}}Route extends GoRouteData {
  const {{filename.pascalCase()}}Route();

  static const String path = '/{{filename.snakeCase()}}';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const {{filename.pascalCase()}}Page();
}
