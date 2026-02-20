part of 'car_body_bloc.dart';

@freezed
class CarBodyState with _$CarBodyState {
  const factory CarBodyState.loading() = Loading;
  const factory CarBodyState.loaded({required List<TempDefectModel> defects}) =
      Loaded;
  const factory CarBodyState.error(String? errorMessage) = Error;
}
