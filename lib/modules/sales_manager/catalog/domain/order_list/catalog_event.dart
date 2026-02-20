part of 'catalog_bloc.dart';

@freezed
class CatalogEvent with _$CatalogEvent {
  const factory CatalogEvent.loadCatalog({
    Filter? filter,
    int? offset,
    List<AutoInfo>? prevContent,
  }) = LoadCatalog;
}
