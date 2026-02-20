part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.userLogOut() = UserLogOut;
  const factory UserEvent.updateUserRole(UserRoleEnum role) = UpdateUserRole;
}
