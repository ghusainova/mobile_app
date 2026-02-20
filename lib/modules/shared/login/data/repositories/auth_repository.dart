import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../services/local_storage/token_manager/token_manager.dart';
import '../../../../../config/app/app_config.dart';
import '../models/user/log_in_credentials.dart';
import '../models/user/token.dart';
import '../providers/auth_api_provider.dart';

@Singleton(order: -8)
class AuthRepository {
  final AuthApiProvider authApiProvider;
  final AppConfig appConfig;
  final TokenManager tokenManager;

  const AuthRepository({
    required this.appConfig,
    required this.tokenManager,
    required this.authApiProvider,
  });

  Future<LogInCredentials?> loadCachedCredentials() async {
    return await tokenManager.getLoginCredentials();
  }

  Future<void> storeLogInCredentials(String login, String password) async {
    await tokenManager.storeLogInCredentials(login, password);
  }

  Future<Token> userLogIn(String login, String password) async {
    final token = await authApiProvider.logIn(login, password);
    await tokenManager.storeTokens(token);

    return token;
  }

  Future<void> userLogOut() async {
    final token = await tokenManager.accessToken;
    await authApiProvider.logOut('Bearer $token');
    await tokenManager.clearAllStorage();
  }

  Future<void> updateUserRoles() async {
    final token = await tokenManager.accessToken;
    await authApiProvider.updateRoles('Bearer $token');
  }

  Future<String?> checkAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = packageInfo.version;
    final token = await tokenManager.accessToken;
    final response =
        await authApiProvider.checkAppVersion('Bearer $token', appVersion);

    if ((response?.downloadLink ?? '').isNotEmpty) {
      return response!.downloadLink;
    }

    return null;
  }
}
