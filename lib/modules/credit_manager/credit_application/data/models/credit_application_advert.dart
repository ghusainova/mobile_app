import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/credit_application_advert.freezed.dart';
part 'generated/credit_application_advert.g.dart';

@freezed
class CreditApplicationAdvert with _$CreditApplicationAdvert {
  const factory CreditApplicationAdvert({
    @Default('') String number,
    @Default('') String urlAdvert,
  }) = _CreditApplicationAdvert;

  factory CreditApplicationAdvert.fromJson(Map<String, dynamic> json) =>
      _$CreditApplicationAdvertFromJson(json);
}
