part of 'car_info_bloc.dart';

@freezed
class CarInfoState with _$CarInfoState {
  const factory CarInfoState.loading() = Loading;
  const factory CarInfoState.loaded({required Auto carInfo}) = Loaded;
  const factory CarInfoState.error(String? message) = Error;
}
