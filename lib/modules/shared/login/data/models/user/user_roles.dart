import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enum/user_role_enum.dart';

part 'generated/user_roles.freezed.dart';

@freezed
class UserRoles with _$UserRoles {
  const factory UserRoles(
    List<UserRoleEnum> rolesList,
  ) = _UserRoles;

  factory UserRoles.fromJson(String token) {
    final json = _getJsonFromJWT(token);

    final groupRoles = json!['groups'] as List<dynamic>?;
    final mappedRoles = _mapRolesToEnum(groupRoles);

    return UserRoles(mappedRoles);
  }

  static Map<String, dynamic>? _getJsonFromJWT(String token) {
    if (token.isEmpty) {
      return null;
    }

    final parts = token.split('.');
    final payload = parts[1];
    final normalizedSource = base64Url.normalize(payload);
    final tokenDataString = utf8.decode(base64Url.decode(normalizedSource));

    return jsonDecode(tokenDataString);
  }

  static List<UserRoleEnum> _mapRolesToEnum(List<dynamic>? roles) {
    final rolesList = (roles ?? []).map((e) => e.toString()).toList();
    final mappedRoles = rolesList
        .map((e) => UserRoleEnum.values
            .firstWhereOrNull((element) => element.code == e),)
        .toSet()
        .where((element) => element != null)
        .map((e) => e!)
        .toList();

    return mappedRoles;
  }
}

UserRoleEnum? manageUserRoles(String accessToken) {
  final userRoles = UserRoles.fromJson(accessToken);

  if (userRoles.rolesList.isEmpty) {
    return null;
  }

  if (userRoles.rolesList.contains(UserRoleEnum.admin)) {
    return UserRoleEnum.admin;
  }

  return userRoles.rolesList.first;
}

List<UserRoleEnum> getRolesList(String accessToken) {
  final userRoles = UserRoles.fromJson(accessToken);
  return userRoles.rolesList;
}
