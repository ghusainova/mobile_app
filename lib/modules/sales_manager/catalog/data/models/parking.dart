import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/parking.freezed.dart';
part 'generated/parking.g.dart';

@freezed
class Parking with _$Parking {
  const factory Parking({
    int? row,
    int? slot,
  }) = _Parking;

  factory Parking.fromJson(Map<String, dynamic> json) =>
      _$ParkingFromJson(json);
}
