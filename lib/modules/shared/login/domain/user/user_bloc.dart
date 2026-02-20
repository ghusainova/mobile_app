import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/logs/log.dart';
import '../../data/enum/user_role_enum.dart';
import '../../data/models/user/user.dart';
import '../../data/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'generated/user_bloc.freezed.dart';

@Singleton()
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(const _Initial()) {
    on<UpdateUserRole>(_updateUserRole);
  }

  User? _user;
  User? get user => _user;

  Future<void> getUserData() async {
    try {
      final user = await userRepository.getUserData();
      _user = user;
    } on DioException catch (e) {
      logger.e(e);
    }
  }

  void _updateUserRole(
    UpdateUserRole event,
    Emitter<UserState> emit,
  ) {
    //TODO:refactor
    if (_user != null) {
      _user = _user!.copyWith(
        userRole: event.role,
        isAdmin: true,
      );
    } else {
      _user = User(
        userRole: event.role,
        isAdmin: true,
      );
    }
  }
}
