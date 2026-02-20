part of '{{filename.snakeCase()}}_bloc.dart';

@freezed
class {{filename.pascalCase()}}State with _${{filename.pascalCase()}}State {
  const factory {{filename.pascalCase()}}State.loading() = Loading;
  const factory {{filename.pascalCase()}}State.loaded({required {{filename.pascalCase()}} {{filename.camelCase()}}}) = Loaded;
  const factory {{filename.pascalCase()}}State.error(String? message) = Error;
}
