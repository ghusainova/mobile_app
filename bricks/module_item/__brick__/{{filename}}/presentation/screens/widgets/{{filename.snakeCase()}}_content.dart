
{{^is_stateless}}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/{{filename.snakeCase()}}/{{filename.snakeCase()}}_bloc.dart';

class {{filename.pascalCase()}}Content extends StatelessWidget {
  const {{filename.pascalCase()}}Content({super.key});

  @override
  Widget build(BuildContext context) {
    final {{filename.camelCase()}} = context.read<{{filename.pascalCase()}}Bloc>().{{filename.camelCase()}};
    return const SizedBox();
  }
}
{{/is_stateless}}
