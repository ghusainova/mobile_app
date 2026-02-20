import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../enum/filter_sort_enum.dart';

part 'generated/filter.g.dart';
part 'generated/filter.freezed.dart';

String? fromStringListToJson(List<String>? value) {
  if ((value ?? []).isEmpty) {
    return null;
  }

  return value!.join(',');
}

List<String>? fromStringToList(String? value) {
  if ((value ?? '').isEmpty) {
    return null;
  }

  return value!.split(', ');
}

String? fromEnumToJson(FilterSortEnum value) {
  return value.code;
}

FilterSortEnum fromStringToEnum(String? value) {
  return FilterSortEnum.values
          .firstWhereOrNull((element) => element.code == value) ??
      FilterSortEnum.latest;
}

@freezed
class Filter with _$Filter {
  const factory Filter({
    @JsonKey(
      fromJson: fromStringToList,
      toJson: fromStringListToJson,
    )
    List<String>? brand,
    @JsonKey(
      fromJson: fromStringToList,
      toJson: fromStringListToJson,
    )
    List<String>? model,
    String? lowerPrice,
    String? upperPrice,
    String? lowerYear,
    String? upperYear,
    String? vin,
    String? bodyNumber,
    String? parkingRow,
    String? parkingSlot,
    String? transmission,
    String? bodyType,
    String? drivetrain,
    String? mileage,
    @JsonKey(
      fromJson: fromStringToList,
      toJson: fromStringListToJson,
    )
    List<String>? color,
    @JsonKey(
      fromJson: fromStringToList,
      toJson: fromStringListToJson,
    )
    List<String>? engineVolume,
    String? searchValue,
    @JsonKey(
      toJson: fromEnumToJson,
      fromJson: fromStringToEnum,
    )
    @Default(FilterSortEnum.latest)
    FilterSortEnum sortBy,
  }) = _Filter;

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
}
