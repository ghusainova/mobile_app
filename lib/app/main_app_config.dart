import 'package:injectable/injectable.dart';

import '../modules/shared/_data/constants/base_urls.dart';
import '../config/app/app_config.dart';

@Singleton(as: AppConfig, order: -100)
@prod
class ProdAppConfig implements AppConfig {
  @override
  String get envType => Environment.prod;

  @override
  String get resaleBaseUrl => prodResaleBaseUrl;

  @override
  String get masterBaseUrl => prodMasterBaseUrl;

  @override
  String get creditBaseUrl => prodCreditBaseUrl;
}

@Singleton(as: AppConfig, order: -15)
@test
class TestAppConfig implements AppConfig {
  @override
  String get envType => Environment.test;

  @override
  String get resaleBaseUrl => devResaleBaseUrl;

  @override
  String get masterBaseUrl => devMasterBaseUrl;

  @override
  String get creditBaseUrl => testCreditBaseUrl;
}

@Singleton(as: AppConfig, order: -10)
@dev
class DevAppConfig implements AppConfig {
  @override
  String get envType => Environment.dev;

  @override
  String get resaleBaseUrl => devResaleBaseUrl;

  @override
  String get masterBaseUrl => devMasterBaseUrl;

  @override
  String get creditBaseUrl => devCreditBaseUrl;
}
