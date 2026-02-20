import 'package:injectable/injectable.dart';

import '../../../../../services/local_storage/token_manager/token_manager.dart';
import '../enum/user_role_enum.dart';
import '../models/user/user.dart';
import '../models/user/user_roles.dart';
import '../providers/user_api_provider.dart';

@Singleton()
class UserRepository {
  final UserApiProvider userApiProvider;
  final TokenManager tokenManager;

  UserRepository({
    required this.userApiProvider,
    required this.tokenManager,
  });

  Future<User> getUserData() async {
    final accessToken = await tokenManager.accessToken;
    UserRoleEnum? userRole;

    if (accessToken != null) {
      userRole = manageUserRoles(accessToken);
    }

    final user = await userApiProvider.getUserInfo();
    final roleDefinedUser = user.copyWith(userRole: userRole);

    return roleDefinedUser;
  }
}
