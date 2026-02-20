import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/client.freezed.dart';
part 'generated/client.g.dart';

@freezed
class Client with _$Client {
  const factory Client({
    @Default('') String middleName,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String iin,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}
