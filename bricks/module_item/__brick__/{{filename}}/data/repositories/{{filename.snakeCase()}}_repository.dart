import 'package:injectable/injectable.dart';

import '../models/{{filename.snakeCase()}}.dart';
import '../providers/{{filename.snakeCase()}}_api_provider.dart';

@lazySingleton
class {{filename.pascalCase()}}Repository {
  final {{filename.pascalCase()}}ApiProvider provider;
  const {{filename.pascalCase()}}Repository({required this.provider});

  Future<{{filename.pascalCase()}}> get{{filename.pascalCase()}}() async {
    return await provider.get{{filename.pascalCase()}}();
  }
}
