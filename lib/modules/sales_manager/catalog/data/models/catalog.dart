import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/catalog.g.dart';
part 'generated/catalog.freezed.dart';

@Freezed(genericArgumentFactories: true)
class Catalog<T> with _$Catalog<T> {
  factory Catalog({
    @Default([]) List<T> orders,
    @Default(0) int totalCount,
  }) = _Catalog;

  factory Catalog.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT,) =>
      _$CatalogFromJson(json, fromJsonT);
}
