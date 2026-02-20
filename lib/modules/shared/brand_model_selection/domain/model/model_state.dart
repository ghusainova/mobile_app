part of 'model_bloc.dart';

@freezed
class ModelState with _$ModelState {
  const factory ModelState.initial() = _Initial;
  const factory ModelState.loading() = _Loading;
  const factory ModelState.loaded({required List<String> models}) = _Loaded;
  const factory ModelState.error({String? message}) = _Error;
}
