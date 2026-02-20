part of 'owner_data_bloc.dart';

@freezed
class OwnerDataState with _$OwnerDataState {
  const factory OwnerDataState.loading() = _Loading;
  const factory OwnerDataState.loaded(OwnerData ownerInfo) = _Loaded;
  const factory OwnerDataState.error(String? error) = _Error;
}
