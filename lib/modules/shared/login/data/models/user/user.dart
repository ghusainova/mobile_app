import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../enum/user_role_enum.dart';

part 'generated/user.freezed.dart';
part 'generated/user.g.dart';

@freezed
class User with _$User {
  const factory User({
    String? userFirstName,
    String? userLastName,
    String? userLogin,
    String? region,
    String? serviceId,
    @JsonKey(includeFromJson: false, includeToJson: false)
    UserRoleEnum? userRole,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false)
    bool isAdmin,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

String? getUserCredentials(User? user) {
  if ((user?.userFirstName ?? '').isNotEmpty &&
      (user?.userLastName ?? '').isNotEmpty) {
    return '${toBeginningOfSentenceCase(user!.userFirstName)} ${user.userLastName![0].toUpperCase()}.';
  }

  return user?.userLogin;
}
