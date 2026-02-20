import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@Singleton(order: -10)
class SecuredStorage {
  final _storage = const FlutterSecureStorage();

  const SecuredStorage();

  FlutterSecureStorage get storage => _storage;
}
