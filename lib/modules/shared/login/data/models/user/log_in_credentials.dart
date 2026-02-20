import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/log_in_credentials.g.dart';
part 'generated/log_in_credentials.freezed.dart';

@freezed
class LogInCredentials with _$LogInCredentials {
  const factory LogInCredentials({
    required String login,
    required String password,
  }) = _LogInCredentials;

  factory LogInCredentials.fromJson(Map<String, dynamic> json) =>
      _$LogInCredentialsFromJson(json);
}
