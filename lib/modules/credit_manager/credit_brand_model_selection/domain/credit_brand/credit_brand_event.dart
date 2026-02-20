part of 'credit_brand_bloc.dart';

@freezed
class CreditBrandEvent with _$CreditBrandEvent {
  const factory CreditBrandEvent.load({
    int? offset,
    List<String>? prevContent,
  }) = _Load;
  const factory CreditBrandEvent.search({
    required String searchValue,
  }) = _Search;
}
