import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/token.g.dart';
part 'generated/token.freezed.dart';

@freezed
class Token with _$Token {
  const factory Token({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
