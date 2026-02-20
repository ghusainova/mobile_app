import 'package:freezed_annotation/freezed_annotation.dart';

import 'credit_media_file.dart';

part 'generated/credit_media_capture_vin_response.freezed.dart';
part 'generated/credit_media_capture_vin_response.g.dart';

@freezed
class CreditMediaCaptureVinResponse with _$CreditMediaCaptureVinResponse {
  factory CreditMediaCaptureVinResponse({
    @Default([]) List<CreditMediaFile> files,
  }) = _CreditMediaCaptureVinResponse;

  factory CreditMediaCaptureVinResponse.fromJson(Map<String, dynamic> json) =>
      _$CreditMediaCaptureVinResponseFromJson(json);
}
