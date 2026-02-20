part of 'catalog_bloc.dart';

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState.loadingList() = LoadingList;
  const factory CatalogState.emptyList() = EmptyList;
  const factory CatalogState.hasContent(List<AutoInfo> catalogResponse) =
      HasContent;
  const factory CatalogState.error(String? errorMessage) = _Error;
}
