part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started({bool? forceLogOut}) = Started;
  const factory AuthEvent.loginUser({
    required String login,
    required String password,
  }) = LoginUser;
  const factory AuthEvent.logoutUser() = LogoutUser;
}
