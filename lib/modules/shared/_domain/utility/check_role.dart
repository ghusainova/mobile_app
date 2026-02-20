import '../../../../config/injectable/injectable.dart';
import '../../login/data/enum/user_role_enum.dart';
import '../../login/domain/user/user_bloc.dart';

bool isManager(UserRoleEnum role) {
  final currentRole = getIt.get<UserBloc>().user?.userRole;
  return currentRole == role;
}
