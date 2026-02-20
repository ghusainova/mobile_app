import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/injectable/injectable.dart';
import '../../../../../config/logs/log.dart';
import '../../data/models/user/token.dart';
import '../../data/repositories/auth_repository.dart';
import '../../../../../config/app/app_config.dart';
import '../user/user_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'generated/auth_bloc.freezed.dart';

@Singleton(order: -6)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(
    this.authRepository,
  ) : super(const _Initial()) {
    on<Started>(_onStarted);
    on<LoginUser>(_authUser);
    on<LogoutUser>(_logOutUser);
  }

  Future<void> _onStarted(Started event, Emitter<AuthState> emit) async {
    emit(const Loading());
    final credentials = await authRepository.loadCachedCredentials();

    if (credentials != null && event.forceLogOut == null) {
      add(LoginUser(login: credentials.login, password: credentials.password));
    } else {
      emit(_Initial(login: credentials?.login));
    }
  }

  Future<void> _authUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(const Loading());

    try {
      final token = await logIn(login: event.login, password: event.password);
      final updateUrl = await _checkAppVersion();

      if (updateUrl != null) {
        emit(const _Initial());

        await launchUrl(
          Uri.parse(updateUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        emit(AuthorizedState(token: token));
      }
    } on DioException catch (e) {
      emit(_Error(message: e.message));
      emit(_Initial(login: event.login));
    }
  }

  Future<Token> logIn({required String login, required String password}) async {
    final token = await authRepository.userLogIn(login, password);
    await authRepository.storeLogInCredentials(login, password);
    await authRepository.updateUserRoles();
    await getIt.get<UserBloc>().getUserData();

    return token;
  }

  Future<void> _logOutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(const Loading());

    try {
      await logOut();
      emit(const _Initial());
    } on DioException catch (e) {
      emit(_Error(message: e.message));
      emit(const _Initial());
    }
  }

  Future<void> logOut({bool forceLogOut = false}) async {
    if (forceLogOut) {
      add(const Started(forceLogOut: true));
    }

    await authRepository.userLogOut();
  }

  Future<String?> _checkAppVersion() async {
    if (getIt.get<AppConfig>().envType == Environment.prod) {
      try {
        final response = await authRepository.checkAppVersion();
        return response;
      } on DioException catch (e) {
        logger.e(e);
        return null;
      }
    }

    return null;
  }
}
