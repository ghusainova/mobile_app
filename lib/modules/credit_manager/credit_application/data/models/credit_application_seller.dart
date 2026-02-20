import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_application_seller.freezed.dart';
part 'generated/credit_application_seller.g.dart';

@freezed
class CreditApplicationSeller with _$CreditApplicationSeller {
  const factory CreditApplicationSeller({
    @Default(0) int id,
    @Default('') String iin,
    @Default('') String lastName,
    @Default('') String firstName,
    @Default('') String middleName,
    @Default(false) bool isSeller,
  }) = _CreditApplicationSeller;

  factory CreditApplicationSeller.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationSellerFromJson(json);
}
