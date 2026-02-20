import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/paint_thickness.freezed.dart';
part 'generated/paint_thickness.g.dart';

@freezed
class PaintThickness with _$PaintThickness {
  const factory PaintThickness({
    @Default('') String microMeterMax,
    @Default('') String microMeterMin,
  }) = _PaintThickness;

  factory PaintThickness.fromJson(Map<String, dynamic> json) =>
      _$PaintThicknessFromJson(json);
}
