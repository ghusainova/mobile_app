part of 'credit_brand_bloc.dart';

@freezed
class CreditBrandState with _$CreditBrandState {
  const factory CreditBrandState.loading() = _Loading;
  const factory CreditBrandState.loaded({required List<String> brands}) =
      _Loaded;
  const factory CreditBrandState.error({String? message}) = _Error;
}
