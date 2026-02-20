part of 'brand_bloc.dart';

@freezed
class BrandState with _$BrandState {
  const factory BrandState.initial() = _Initial;
  const factory BrandState.loading() = _Loading;
  const factory BrandState.loaded({required List<String> brands}) = _Loaded;
  const factory BrandState.error({String? message}) = _Error;
}
