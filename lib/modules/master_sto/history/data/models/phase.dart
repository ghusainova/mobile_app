import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/phase.freezed.dart';
part 'generated/phase.g.dart';

@freezed
class Phase with _$Phase {
  const Phase._();

  factory Phase({
    @Default('') String phaseName,
    @Default('') String stageName,
    @Default(false) bool defectStatus,
    @Default(false) bool availabilityStatus,
    String? imageName,
  }) = _Phase;

  factory Phase.fromJson(Map<String, dynamic> json) => _$PhaseFromJson(json);

  bool get isDefectsRoute => imageName == 'cowl';
  bool get isFinalStageRoute => imageName == 'final_info' && availabilityStatus;
  bool get isVideoVinCapture => imageName == 'video' && availabilityStatus;
  bool get isPhotoVinCapture => imageName == 'photo' && availabilityStatus;
}
