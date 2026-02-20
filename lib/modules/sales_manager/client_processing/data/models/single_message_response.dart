import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/single_message_response.g.dart';
part 'generated/single_message_response.freezed.dart';

@freezed
class SingleMessageResponse with _$SingleMessageResponse {
  const factory SingleMessageResponse(String message) = _SingleMessageResponse;

  factory SingleMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleMessageResponseFromJson(json);
}
