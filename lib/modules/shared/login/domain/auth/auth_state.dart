part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial({String? login}) = _Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.authorizedState({required Token token}) =
      AuthorizedState;
  const factory AuthState.error({String? message}) = _Error;
}
