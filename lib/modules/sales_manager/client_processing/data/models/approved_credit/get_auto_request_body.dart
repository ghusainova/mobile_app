import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../shared/_data/models/auto_info.dart';

part 'generated/get_auto_request_body.freezed.dart';
part 'generated/get_auto_request_body.g.dart';

@freezed
class GetAutoRequestBody with _$GetAutoRequestBody {
  const factory GetAutoRequestBody({
    String? brand,
    String? model,
    String? bodyType,
    num? year,
    num? iin,
    num? price,
  }) = _GetAutoRequestBody;

  factory GetAutoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$GetAutoRequestBodyFromJson(json);

  factory GetAutoRequestBody.fromAutoInfo(AutoInfo? autoInfo) =>
      GetAutoRequestBody(
        brand: autoInfo?.auto?.brand,
        model: autoInfo?.auto?.model,
        bodyType: autoInfo?.auto?.bodyType,
        year: autoInfo?.auto?.year,
        price: int.tryParse(autoInfo?.priceSelling ?? ''),
      );
}
