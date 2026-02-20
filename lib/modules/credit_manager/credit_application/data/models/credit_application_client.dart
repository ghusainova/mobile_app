import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_application_client.freezed.dart';
part 'generated/credit_application_client.g.dart';

@freezed
class CreditApplicationClient with _$CreditApplicationClient {
  const factory CreditApplicationClient({
    @Default(0) int id,
    @Default('') String iin,
    @Default('') String lastName,
    @Default('') String firstName,
    @Default('') String phoneNumber,
  }) = _CreditApplicationClient;

  factory CreditApplicationClient.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationClientFromJson(json);
}
