part of 'main_info_bloc.dart';

@freezed
class MainInfoState with _$MainInfoState {
  const factory MainInfoState.loading() = Loading;
  const factory MainInfoState.loaded({required MainInfo mainInfo}) = Loaded;
  const factory MainInfoState.error(String? message) = Error;
  const factory MainInfoState.saved() = Saved;
}
