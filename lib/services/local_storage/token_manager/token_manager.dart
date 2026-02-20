import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../config/injectable/injectable.dart';
import '../../../modules/shared/queue/data/models/branch_user.dart';
import '../../../modules/shared/login/data/models/user/log_in_credentials.dart';
import '../../../modules/shared/login/data/models/user/token.dart';
import '../../../modules/shared/login/data/providers/auth_api_provider.dart';
import '../../../config/logs/log.dart';
import '../secured_storage.dart';
import '../system_options/system_options.dart';
import 'token_keys_constants.dart';

@Singleton(order: -9)
class TokenManager {
  Completer<String?>? _refreshCompleter;

  final SecuredStorage securedStorage;
  final AuthApiProvider authApiProvider;

  TokenManager(this.securedStorage, this.authApiProvider);

  Future<LogInCredentials?> getLoginCredentials() async {
    String? login;
    String? password;

    try {
      login = await securedStorage.storage.read(key: loginKey);
      password = await securedStorage.storage.read(key: passwordKey);
    } catch (e) {
      logger.e(e);
      return null;
    }

    if (login == null || password == null) {
      return null;
    }

    return LogInCredentials(login: login, password: password);
  }

  Future<void> storeLogInCredentials(String login, String password) async {
    try {
      await securedStorage.storage.write(key: loginKey, value: login);
      await securedStorage.storage.write(key: passwordKey, value: password);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> clearLogInCredentials() async {
    try {
      await securedStorage.storage.delete(key: loginKey);
      await securedStorage.storage.delete(key: passwordKey);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<BranchUser?> getBranchUser() async {
    try {
      final branchUser = await securedStorage.storage.read(key: branchUserKey);

      if (branchUser != null) {
        return BranchUser.fromJson(jsonDecode(branchUser));
      }
    } catch (e) {
      logger.e(e);
      return null;
    }

    return null;
  }

  Future<void> storeBranchUser(BranchUser? branchUser) async {
    try {
      if (branchUser == null) {
        await securedStorage.storage.write(key: branchUserKey, value: null);
      } else {
        await securedStorage.storage.write(
          key: branchUserKey,
          value: jsonEncode(branchUser.toJson()),
        );
      }
    } catch (e) {
      logger.e(e);
    }
  }

  Future<Token?> getTokens() async {
    String? accessToken;
    String? refreshToken;

    try {
      accessToken = await securedStorage.storage.read(key: accessTokenKey);
      refreshToken = await securedStorage.storage.read(key: refreshTokenKey);
    } catch (e) {
      logger.e(e);
      return null;
    }

    if (accessToken == null || refreshToken == null) {
      return null;
    }

    return Token(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<void> storeTokens(Token tokens) async {
    try {
      await securedStorage.storage
          .write(key: accessTokenKey, value: tokens.accessToken);
      await securedStorage.storage
          .write(key: refreshTokenKey, value: tokens.refreshToken);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> clearAllStorage() async {
    final queueIpAddress =
        await getIt.get<SystemOptions>().getCachedIpAddress();
    await securedStorage.storage.deleteAll();

    //delete excluding items logic
    if ((queueIpAddress ?? '').isNotEmpty) {
      await getIt.get<SystemOptions>().storeQueueIpAddress(queueIpAddress!);
    }
  }

  Future<void> refreshAccessToken() async {
    if (_refreshCompleter != null) {
      await _refreshCompleter!.future;
      return;
    }

    _refreshCompleter = Completer<String?>();

    try {
      final refreshToken =
          await securedStorage.storage.read(key: refreshTokenKey);
      await securedStorage.storage.delete(key: accessTokenKey);

      if (refreshToken == null) {
        throw Exception('No refresh token present');
      }
      Token token;
      token = await authApiProvider.refreshToken(refreshToken);
      logger.d(' token: $token');
      await storeTokens(token);
      _refreshCompleter!.complete(token.accessToken);
    } finally {
      _refreshCompleter = null;
    }
  }

  Future<String?> get accessToken async {
    if (_refreshCompleter != null) {
      return await _refreshCompleter!.future;
    }

    try {
      return await securedStorage.storage.read(key: accessTokenKey);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<String?> get refreshToken async {
    try {
      return await securedStorage.storage.read(key: refreshTokenKey);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
