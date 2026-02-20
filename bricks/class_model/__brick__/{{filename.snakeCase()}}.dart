{{#add_freezed}}import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/{{filename.snakeCase()}}.freezed.dart';
part 'generated/{{filename.snakeCase()}}.g.dart';

@freezed
class {{filename.pascalCase()}} with _${{filename.pascalCase()}} {
  const factory {{filename.pascalCase()}}({
    @Default('') String? field1,
    @Default('') String? field2,
  }) = _{{filename.pascalCase()}};

  factory {{filename.pascalCase()}}.fromJson(Map<String, dynamic> json) =>
      _${{filename.pascalCase()}}FromJson(json);
}

{{/add_freezed}}
{{^add_freezed}}
class {{filename.pascalCase()}} {
  String field1;
  {{filename.pascalCase()}}({
    this.field1 = '',
  });

  factory {{filename.pascalCase()}}.fromJson(Map<dynamic, dynamic> json) {
    return {{filename.pascalCase()}}(
      field1: json['field1'] ?? '',
    );
  }
}
{{/add_freezed}}
